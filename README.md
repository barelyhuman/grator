# grator

Simple Utility to run migrations with a retry

### Motivation 
A few services generate their own migrations for us to use but the order of these migration queries are often invalid and never migrate properly and 
cause a lot of issues when needed. The cli utility simply goes through the set of queries and runs them with retry attempts to make sure each statement is run at least 3 times. In the future you can obviously change this number. 

### Installation 
```sh
npm i -g @barelyreaper/grator
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
