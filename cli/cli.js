#!/usr/bin/env node

const meow = require("meow");
const { grator } = require("./grator");
const usage = require("./usage");

const cli = meow(usage, {
	flags: {
		config: {
			type: "string",
			default: "./grator.json",
			alias: "c",
		},
		directory: {
			type: "string",
			default: "./migrations",
			alias: "d",
		},
		silent: {
			type: "boolean",
			default: false,
			alias: "s",
		},
		retry: {
			type: "number",
			default: 3,
			alias: "r",
		},
	},
});

function main() {
	if (cli.input.length <= 0) {
		console.log(usage);
		process.exit(0);
	}
	grator(cli.input, cli.flags);
}

main();
