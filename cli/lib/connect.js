const knex = require('knex');

function connect (connectionConfig = {
  host: 'localhost',
  port: 5432,
  database: 'postgres',
  user: '',
  password: '',
  max: 0,
  timeout: 0
}) {
  const instance = knex({
    client: 'pg',
    connection: connectionConfig
  })
  return instance
}

exports.connect = connect 
