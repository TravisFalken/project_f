class Location {
  constructor(locationID, longitude, latitude) {
    this.locationID = locationID;
    this.longitude = longitude;
    this.latitude = latitude;
  }

  getLocationID() {
    return this.locationID;
  }

  setLocationID(locationID) {
    this.locationID = locationID;
  }

  getLongitude() {
    return this.longitude;
  }

  setLongitude(longitude) {
    this.longitude = longitude;
  }

  getLatitude() {
    return this.latitude;
  }

  setLatitude(latitude) {
    this.latitude = latitude;
  }

  //Formats data correctly to insert into database
  marshallData() {
    return `POINT(${this.longitude} ${this.latitude})`;
  }

  //Format data correctly from the database
  async unMarshallData(data) {
    return new Promise(async (resolve, reject) => {
      try {
        //Get the numbers only
        const endLength = data.length - 1;
        const onlyNumbers = data.subString(6, endLength);
        //Split numbers by the space
        const locations = onlyNumbers.split(' ');

        this.longitude = locations[0];
        this.latitude = locations[1];
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  }
}

module.exports = Location;
