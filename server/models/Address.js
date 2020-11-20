class Address {
  constructor(
    addressID,
    streetNum,
    streetName,
    suburb,
    city,
    region,
    country,
    postalCode,
    location
  ) {
    this.addressID = addressID;
    this.streetNum = streetNum;
    this.streetName = streetName;
    this.suburb = suburb;
    this.city = city;
    this.region = region;
    this.country = country;
    this.postalCode = postalCode;
    this.location = location;
  }

  getAddressID() {
    return this.addressID;
  }

  setAddressID(addressID) {
    this.addressID = addressID;
  }

  getStreetNum() {
    return this.streetNum;
  }

  setStreetNum(streetNum) {
    this.streetNum = streetNum;
  }

  getStreetName() {
    return this.streetName;
  }

  setStreetName(streetName) {
    this.streetName = streetName;
  }

  getSuburb() {
    return this.suburb;
  }

  setSuburb(suburb) {
    this.suburb = suburb;
  }

  getCity() {
    return this.city;
  }

  setCity(city) {
    this.city = city;
  }

  getRegion() {
    return this.region;
  }

  setRegion(region) {
    this.region = region;
  }

  getCountry() {
    return this.country;
  }

  setCountry(country) {
    this.country = country;
  }

  getPostalCode() {
    return this.postalCode;
  }

  setPostalCode(postalCode) {
    this.postalCode = postalCode;
  }

  getLocation() {
    return this.location;
  }

  setLocation(location) {
    this.location = location;
  }

  getStreetAddress() {
    return `${this.streetNum} ${this.streetNum} ${this.suburb} ${this.city} ${this.country}`;
  }
}

module.exports = Address;
