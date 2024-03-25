const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  connectionLimit: 10,
  host: '34.125.67.227',
  user: 'root',
  password: 'root',
  database: 'MURAKI_COMIC2',
  port: 3307,
  waitForConnections: true
});

module.exports = pool;