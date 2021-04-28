import path from 'path'
import fs from 'fs'
import { connect } from './lib/connect.js'
import conch from '@barelyreaper/conch'
import ora from 'ora'

const maxTries = 4
let completedTries = 0
let queriesToRun = []

export async function grator (cliInput, cliArgs = { config: '', directory: '' }) {
  const spinner = ora('Starting').start()
  try {
    const configPath = path.resolve(cliArgs.config)
    const isConfigExists = fs.existsSync(configPath)
    spinner.text = 'Checking if config exists'
    if (!isConfigExists) {
      spinner.fail('Failed to complete migrations')
      throw new Error("Config File doesn't exist, if you are using a custom config, please point to it using -c or --config")
    }
    const config = JSON.parse(fs.readFileSync(configPath).toString())

    let migrationFile
    const migrationPath = path.resolve(cliArgs.directory)
    const isMigrationFolderExists = fs.existsSync(migrationPath)

    spinner.text = 'Checking if migrations exist'
    if (!isMigrationFolderExists) {
      spinner.fail('Failed to complete migrations')
      throw new Error("Migrations Folder doesn't exist, if you are using a different folder, please point to it using -d or --directory")
    }

    switch (cliInput[0]) {
      case 'up': {
        migrationFile = path.join(migrationPath, 'up.sql')
        break
      }
      case 'down': {
        migrationFile = path.join(migrationPath, 'down.sql')
        break
      }
      default: {
        throw new Error('Please provide an instruction with the command, `up` or `down`')
      }
    }

    const migrationQuery = fs.readFileSync(migrationFile).toString()

    spinner.text = 'Connecting to database...'

    const dbInstance = connect(config.connection)

    const migrationQueryInBatches = {
      query: migrationQuery,
      done: false
    }

    queriesToRun = queriesToRun.concat(migrationQueryInBatches)

    spinner.text = 'Running Migrations'
    spinner.color = 'green'
    while (completedTries < maxTries) {
      await conch(queriesToRun, (queryItem) => runQuery(dbInstance, queryItem), { limit: 1 }).catch(err => {
        queryError(queriesToRun, err)
      })
      completedTries += 1
      queriesToRun = queriesToRun.filter(item => !item.done)
    }

    if (queriesToRun.length > 0) {
      spinner.color = 'red'
      spinner.fail('Failed to complete migrations')
      queryError(queriesToRun)
      process.exit(1)
    }

    spinner.succeed('Done running migrations')
    process.exit(0)
  } catch (err) {
    spinner.fail(String(err) || 'Failed unexpectedly')
    process.exit(1)
  }
}

async function runQuery (db, queryItem) {
  await db.raw(queryItem.query)
  queryItem.done = true
}

function queryError (queries, err) {
  const errorLog = queries.map(item => item.query).join(';\n\n') + '\n' + String(err)
  fs.writeFileSync('grator-error.log', errorLog)
  console.error(new Error(`About ${queries.length} ${queries.length === 1 ? 'query' : 'queries'} failed to execute, please check them again, the failed one's can be found in grator-error.log`))
}
