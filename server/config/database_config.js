const Pool = require('pg').Pool;

//Set up the database pool

const pool = new Pool({
  user: process.env.PG_USER,
  host: process.env.PG_HOST,
  database: process.env.PG_DATABASE,
  password: process.env.PG_PASS,
  port: process.env.PG_PORT,
});

module.exports = {
  //Set up a standard query
  query: (text, params) => {
    return new Promise(async (resolve, reject) => {
      try {
        //Query the database
        const res = await pool.query(text, params);
        resolve(res);
      } catch (e) {
        reject(e);
      }
    });
  },

  //Get a client for transactions
  getClient: async () => {
    return new Promise(async (resolve, reject) => {
      try {
        const client = await pool.connect();
        resolve(client);
      } catch (e) {
        reject(e);
      }
    });
  },
};
