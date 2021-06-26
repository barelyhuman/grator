<h1 align="center">grator</h1>
<p align="center">Simple Utility To Run Migrations With A Retry</p>

 If you like any of my work, you can support me on: https://barelyhuman.dev/donate

[![](https://img.shields.io/badge/license-mit-black?style=for-the-badge)](LICENSE)



## Motivation 

A few services generate their own migrations for us to use but the order of these migration queries are often invalid and never migrate properly and cause a lot of issues when needed. The cli utility simply goes through the set of queries and runs them with retry attempts to make sure each statement is run at least 3 times. In the future you can obviously change this number.

## Features 

- Knex compatible so work with any connector, as long as the files also support the same

### Installation 
```sh
npm i -g @barelyhuman/grator
```


### Usage 

#### Requirements
- A json config file named `grator.json` or anything as long as you point to it with the needed flag
- A folder named `migrations` or any other folder with an `up.sql` and a `down.sql` file based on requirement

```sh
Usage
	$ grator [up|down]

	Options
	  --config, -c configuration file [Default: ./grator.json]
	  --directory, -d  migrations directory, should contain up.sql and down.sql [Default: ./migrations]

	Examples
	  $ grator up -c grator.json	
	  $ grator down -c grator.json -d migrations
```


## License 

[MIT](LICENSE) &copy; Reaper