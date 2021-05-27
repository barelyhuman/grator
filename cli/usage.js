const usage = `
Usage
 $ grator [up|down]
  
Options
 --config, -c configuration file [Default: ./grator.json]
 --directory, -d  migrations directory, should contain up.sql and down.sql [Default: ./migrations]
 --retry, -r  retry count [Default: 3]
 --silent, -s  suppress all logs [Default: false]

Examples
$ grator up -c grator.json
$ grator down -c grator.json -d migrations
$ grator up -c grator.json -d migrations -r 4
$ grator up -c grator.json -d migrations -s
`;

module.exports = usage;
