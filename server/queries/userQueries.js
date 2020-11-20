const db = require('../config/database_config');
const addressQueries = require('./addressQueries');

//@desc     Adds a new user to the database
const addUserQuery = async (newUser) => {
  return new Promise(async (resolve, reject) => {
    //Get a client
    const client = await db.getClient();
    try {
      //Build the query
      let queryString = `INSERT INTO _user(username, email, password, given_name, family_name, phone_num, date_of_birth, created_date`;

      //Start transaction
      await client.query('BEGIN');
      //Check if there is an address
      let addressID;
      console.log('AddressID :', addressID); // for testing
      if (newUser.getAddress() != null) {
        //Add Address to db
        addressID = await addressQueries.addAddressQuery(
          newUser.getAddress(),
          client
        );
      }

      let values = [
        newUser.getUserName(),
        newUser.getEmail(),
        newUser.getPassword(),
        newUser.getGivenName(),
        newUser.getFamilyName(),
        newUser.getPhoneNum(),
        newUser.getDateOfBirth(),
        newUser.getCreatedDate(),
      ];

      //Check if there is an address id
      if (addressID) {
        values.push(addressID);
        queryString += `, address_id`;
      }

      queryString += `) VALUES($1`;
      // Build up the place holders in the query string
      for (let i = 2; i <= values.length; i++) {
        queryString += `,$${i}`;
      }

      queryString += `) RETURNING user_id;`;

      console.log('Query string: ', queryString); // For testing
      console.table(values); // for testing

      //Insert user into the db
      const res = await client.query(queryString, values);

      //Commit the transaction
      await client.query('COMMIT');

      //Get the user ID from the res of the query
      const userID = res.rows[0].user_id;

      resolve(userID);
    } catch (e) {
      await client.query('ROLLBACK');
      reject(e);
    } finally {
      client.release();
    }
  });
};

module.exports = {
  addUserQuery,
};
