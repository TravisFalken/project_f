const db = require('../config/database_config');

//@desc     Add location to the database
const addLocationQuery = async (newLocation, client) => {
  return new Promise(async (resolve, reject) => {
    try {
      //Build the query string
      const queryString = `INSERT INTO _location(location) VALUES($1) RETURNING location_id;`;
      const values = [newLocation.marshallData()];
      let res;

      //Check if there is a client
      if (client) {
        //insert into the database
        res = await client.query(queryString, values);
      } else {
        //insert into databse
        res = await db.query(queryString, values);
      }

      //Get the id from the res
      const id = res.rows[0].location_id;
      resolve(id);
    } catch (e) {
      reject(e);
    }
  });
};

module.exports = {
  addLocationQuery,
};
