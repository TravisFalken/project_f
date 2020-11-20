const asyncHandler = require('../middleware/asyncHandler');
const User = require('../models/User');
const Address = require('../models/Address');
const Location = require('../models/Location');
const geoLocation = require('../utils/geoLocation');
const userQueries = require('../queries/userQueries');
const bcrypt = require('../utils/bcrypt');
const Account = require('../models/Account');

//@desc     Creates a new user in the database
//@route    /api/v1/users
//@access   Public
exports.createUser = asyncHandler(async (req, res, next) => {
  const {
    username,
    email,
    password,
    givenName,
    familyName,
    phoneNum,
    dateOfBirth,
    streetNum,
    streetName,
    suburb,
    city,
    region,
    country,
    postalCode,
  } = req.body;

  console.log('Family name: ', familyName); // for testing
  //Get created date
  const todaysDate = new Date();
  const formattedDate = `${todaysDate.getDate()}/${todaysDate.getMonth()}/${todaysDate.getFullYear()}`;
  let newAddress = new Address(
    null,
    streetNum,
    streetName,
    suburb,
    city,
    region,
    country,
    postalCode,
    null
  );

  //Get the geo location of the address
  const location = await geoLocation.getGeoLocation(
    newAddress.getStreetAddress()
  );

  newAddress.setLocation(location);

  let user = new User(
    null,
    username,
    email,
    givenName,
    familyName,
    newAddress,
    dateOfBirth,
    formattedDate,
    null,
    phoneNum,
    password
  );
  
  //Encrypt password
  user.setPassword(await bcrypt.encryptString(password));

  //Add new user to database
  user.setID(await userQueries.addUserQuery(user));
  //Send result back to the user
  res.status(200).json({
    success: true,
    data: {
      id: user.getID(),
    },
  });
});