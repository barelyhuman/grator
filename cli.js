#!/usr/bin/env node
import meow from 'meow'
import { grator } from './grator.js'

const cli = meow(`
Usage
  $ grator [up|down]

Options
  --config, -c configuration file [Default: ./grator.json]
  --directory, -d  migrations directory, should contain up.sql and down.sql [Default: ./migrations]

Examples
  $ grator up -c grator.json
  $ grator down -c grator.json -d migrations
`, {
  flags: {
    config: {
      type: 'string',
      default: './grator.json',
      alias: 'c'
    },
    directory: {
      type: 'string',
      default: './migrations',
      alias: 'd'
    }
  }
})

function main () {
  grator(cli.input, cli.flags)
}

main()
