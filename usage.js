const usage = `
Usage
 $ grator [up|down]
  
Options
 --config, -c configuration file [Default: ./grator.json]
 --directory, -d  migrations directory, should contain up.sql and down.sql [Default: ./migrations]

Examples
$ grator up -c grator.json
$ grator down -c grator.json -d migrations
`

export default usage
