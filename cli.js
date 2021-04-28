#!/usr/bin/env node
import meow from 'meow'
import { grator } from './grator.js'
import usage from './usage.js'

const cli = meow(usage, {
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
  if (cli.input.length <= 0) {
    console.log(usage)
    process.exit(0)
  }
  grator(cli.input, cli.flags)
}

main()
