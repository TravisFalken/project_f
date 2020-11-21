const db = require('../config/database_config');
const bcrypt = require('../utils/bcrypt');
const ErrorResponse = require('../utils/ErrorResponse');
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

const updatePasswordQuery = async (userID, password, newPassword, retypedNewPassword) => {
  
  return new Promise(async (resolve, reject) => {
    try{
      let user = getUserQuery(userID);
      if(!user){
        reject(e);
      }

      if(!bcrypt.checkPasswordMatch(user.password, password)){
        reject(new ErrorResponse('Password does not match', 400));
      }

      if(!newPassword === retypedNewPassword){
        reject(new ErrorResponse('New password does not match retyped password', 400));
      }

      const newEncryptedPassword = bcrypt.encryptString(newPassword);

      let response = db.query(` UPDATE _user
                                SET password = $1
                                WHERE user_id = $2;`
                              , [newEncryptedPassword, userID]);
      resolve(response);
    }catch(e){
      reject(e);
    }
  });
}

const getUserQuery = async (userID) => {
  return new Promise(async (resolve, reject) =>{
    try{
      let user = await db.query(` SELECT
                                        user_id
                                    ,   username
                                    ,   email
                                    ,   password
                                    ,   given_name
                                    ,   family_name
                                    ,   phone_num
                                    ,   date_of_birth
                                    ,   created_date
                                    ,   address_id
                                    ,   profile_photo
                                  WHERE user_id = $1;`
                                  , [userID]);
      resolve(user);
    }catch(e){
      reject(e);
    }
  });
};

module.exports = {
  addUserQuery,
  getUserQuery,
  updatePasswordQuery
};
