#!/usr/bin/env node
import meow from 'meow';
import {gator} from './gator.js';

const cli = meow(`
	Usage
	  $ gator [up|down]

	Options
	  --config, -c configuration file [Default: ./gator.json]
	  --directory, -d  migrations directory, should contain up.sql and down.sql [Default: ./migrations]

	Examples
	  $ gator up -c gator.json	
	  $ gator down -c gator.json -d migrations
`, {
	flags: {
		config: {
			type: 'string',
			default: './gator.json',
			alias:'c'
		},
		directory:{
			type:'string',
			default:'./migrations',
			alias:'d'
		}
	}
});

function main(){
	gator(cli.input,cli.flags)
}

main();
