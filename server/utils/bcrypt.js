const bcrypt = require('bcryptjs');

//@desc     Encrypt a string
const encryptString = async (string) => {
  return new Promise(async (resolve, reject) => {
    try {
      //Generate salt for encryption
      const salt = await bcrypt.genSalt(10);

      //Encrypt string
      const encrypt = await bcrypt.hash(string, salt);

      resolve(encrypt);
    } catch (e) {
      reject(e);
    }
  });
};

//@desc   Checks if passwords match
const checkPasswordMatch = async (dbPassword, enteredPassword) => {
  return new Promise(async (resolve, reject) => {
    try{
      const isMatch = await bcrypt.compare(enteredPassword, dbPassword);
      resolve(isMatch); 
    }catch(e){
      reject(e);
    }
  });
};

module.exports = {
  encryptString,
  checkPasswordMatch
};
