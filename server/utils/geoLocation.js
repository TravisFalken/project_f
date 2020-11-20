const Geocoder = require('node-geocoder');
const ErrorResponse = require('./ErrorResponse');
const Location = require('../models/Location');

const options = {
  provider: process.env.GEO_PROVIDER,
  httpAdapter: 'https',
  apiKey: process.env.GEO_API_KEY,
  formatter: null,
};
console.log(options); // for testing
const geocoder = Geocoder(options);

//@desc     Get location for a street address
const getGeoLocation = async (streetAddress) => {
  return new Promise(async (resolve, reject) => {
    try {
      const result = await geocoder.geocode(streetAddress);

      //Check if there is a result
      if (!result) {
        return reject(
          new ErrorResponse('Could not find address location', 400)
        );
      }

      //Create location object
      const location = new Location(
        null,
        result[0].longitude,
        result[1].latitude
      );

      resolve(location);
    } catch (e) {
      reject(e);
    }
  });
};

module.exports = {
  getGeoLocation,
};
