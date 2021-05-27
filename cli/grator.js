const path = require("path");
const fs = require("fs");
const { connect } = require("./lib/connect");
const conch = require("@barelyreaper/conch");
const ora = require("ora");
const usage = require("./usage");
const {parse:psqlParser,deparse:psqlDeparser} = require('pgsql-parser');

let maxTries = 0;
let completedTries = 0;
let queriesToRun = [];
let failedQueries = [];
let queryErrorLogged = false;

async function grator(
	cliInput,
	cliArgs = { config: "", directory: "", retry: 3, silent: false }
) {
	maxTries = cliArgs.retry || 3;
	const spinner = ora({ text: "Starting", isSilent: cliArgs.silent }).start();
	try {
		const configPath = path.resolve(cliArgs.config);
		const isConfigExists = fs.existsSync(configPath);
		spinner.text = "Checking if config exists";
		if (!isConfigExists) {
			spinner.fail("Failed to complete migrations");
			if (!cliArgs.silent) {
				throw new Error(
					"Config File doesn't exist, if you are using a custom config, please point to it using -c or --config"
				);
			}
		}
		const config = JSON.parse(fs.readFileSync(configPath).toString());

		let migrationFile;
		const migrationPath = path.resolve(cliArgs.directory);
		const isMigrationFolderExists = fs.existsSync(migrationPath);

		spinner.text = "Checking if migrations exist";
		if (!isMigrationFolderExists) {
			spinner.fail("Failed to complete migrations");
			if (!cliArgs.silent) {
				throw new Error(
					"Migrations Folder doesn't exist, if you are using a different folder, please point to it using -d or --directory"
				);
			}
		}

		spinner.text = "Reading SQL Files...";
		switch (cliInput[0]) {
			case "up": {
				migrationFile = path.join(migrationPath, "up.sql");
				break;
			}
			case "down": {
				migrationFile = path.join(migrationPath, "down.sql");
				break;
			}
			default: {
				console.log("Invalid Input, please go through the usage again");
				console.log(usage);
				process.exit(0);
			}
		}

		const migrationQuery = fs.readFileSync(migrationFile).toString();

		spinner.text = "Connecting to database...";

		const dbInstance = connect(config.connection);

		const psqlAsTokens = psqlParser(migrationQuery);

		psqlAsTokens.forEach(statement=>{
			const migrationQueryInBatches = {
				query: `${psqlDeparser(statement)}`,
				done: false,
				count: 0,
			};
			queriesToRun = queriesToRun.concat(migrationQueryInBatches);
		});
	

		queriesToRun.forEach((query) => {
			if (!query) {
				return;
			}
			
		});

		spinner.text = "Running Migrations";
		spinner.color = "green";

		queriesToRun = queriesToRun.reverse();

		while (queriesToRun.length > 0) {
			const toRun = queriesToRun.pop();
			try {
				spinner.text = `${toRun.query}`;
				await runQuery(dbInstance, toRun);
			} catch (err) {
				if (toRun.count <= maxTries) {
					toRun.count += 1;
					queriesToRun = queriesToRun.concat(toRun);
					continue;
				} else {
					failedQueries.push(err);
				}
			}
		}

		if (failedQueries.length > 0) {
			spinner.color = "red";
			spinner.fail("Failed to complete migrations");
			queryError(failedQueries, null, cliArgs.silent);
			process.exit(1);
		}

		spinner.succeed("Done running migrations");
		process.exit(0);
	} catch (err) {
		spinner.fail(String(err) || "Failed unexpectedly");
		process.exit(cliArgs.silent ? 0 : 1);
	}
}

async function runQuery(db, queryItem) {
	await db.raw(queryItem.query);
	queryItem.done = true;
	return true;
}

function queryError(queries, err = new Error(""), silent = false) {
	if (queryErrorLogged) {
		return;
	}
	queryErrorLogged = true;
	const errorLog = queries.join(";\n\n") + "\n" + String(err);
	fs.writeFileSync("grator-error.log", errorLog);
	if (!silent) {
		console.error(
			new Error(
				`About ${queries.length} ${
					queries.length === 1 ? "query" : "queries"
				} failed to execute, please check them again, the failed one's can be found in grator-error.log`
			)
		);
	}
}

exports.grator = grator;
