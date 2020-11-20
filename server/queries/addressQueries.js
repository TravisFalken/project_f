const db = require('../config/database_config');
const locationQueries = require('./locationQueries');

//@desc    Adds an address to the database
const addAddressQuery = async (newAddress, client) => {
  return new Promise(async (resolve, reject) => {
    try {
      //Build query
      const queryString = `INSERT into _address(street_num, street_name, suburb, city, region, country, postal_code, location_id)
        VALUES($1,$2,$3,$4,$5,$6,$7,$8) RETURNING address_id;`;

      //Add location to the database
      const locationID = await locationQueries.addLocationQuery(
        newAddress.getLocation(),
        client
      );

      const values = [
        newAddress.getStreetNum(),
        newAddress.getStreetName(),
        newAddress.getSuburb(),
        newAddress.getCity(),
        newAddress.getRegion(),
        newAddress.getCountry(),
        newAddress.getPostalCode(),
        locationID,
      ];

      let res;
      //Check if there is a client
      if (client) {
        //Add address to db
        res = await client.query(queryString, values);
      } else {
        //Add address to db
        res = await db.query(queryString, values);
      }

      //Get the address id
      const addressID = res.rows[0].address_id;

      resolve(addressID);
    } catch (e) {
      reject(e);
    }
  });
};

module.exports = {
  addAddressQuery,
};
