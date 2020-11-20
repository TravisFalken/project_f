class User {
  constructor(
    id,
    username,
    email,
    givenName,
    familyName,
    address,
    dateOfBirth,
    createdDate,
    profilePhotoPath,
    phoneNum,
    password
  ) {
    this.id = id;
    this.username = username;
    this.email = email;
    this.givenName = givenName;
    this.familyName = familyName;
    this.address = address;
    this.dateOfBirth = dateOfBirth;
    this.createdDate = createdDate;
    this.profilePhotoPath = profilePhotoPath;
    this.phoneNum = phoneNum;
    this.password = password;
  }

  getID() {
    return this.id;
  }

  setID(newID) {
    this.id = newID;
  }

  getUserName() {
    return this.username;
  }

  setUserName(newUserName) {
    this.username = newUserName;
  }

  getEmail() {
    return this.email;
  }

  setEmail(newEmail) {
    this.email = newEmail;
  }

  getGivenName() {
    return this.givenName;
  }

  setGivenName(newGivenName) {
    this.givenName = newGivenName;
  }

  getFamilyName() {
    return this.familyName;
  }

  setFamilyName(newFamilyName) {
    this.familyName = newFamilyName;
  }

  getPhoneNum() {
    return this.phoneNum;
  }

  setPhoneNum(phoneNum) {
    this.phoneNum = phoneNum;
  }

  getAddress() {
    return this.address;
  }

  setAddress(newAddress) {
    this.address = newAddress;
  }

  getDateOfBirth() {
    return this.dateOfBirth;
  }

  setDateOfBirth(newDateOfBirth) {
    this.dateOfBirth = newDateOfBirth;
  }

  getCreatedDate() {
    return this.createdDate;
  }

  setCreatedDate(newCreatedDate) {
    this.createdDate = newCreatedDate;
  }

  getProfilePhotoPath() {
    return this.profilePhotoPath;
  }

  setProfilePhotoPath(photoPath) {
    this.profilePhotoPath = photoPath;
  }

  getPassword() {
    return this.password;
  }

  setPassword(password) {
    this.password = password;
  }

  //@desc   Gets the column name for the user table
  static async getColumn(userColumn) {
    return new Promise((resolve, reject) => {
      //Database Columns
      const columns = new Map([
        (['id', 'user_id'],
        ['username', 'username'],
        ['email', 'email'],
        ['password', 'password'],
        ['givenName', 'given_name'],
        ['familyName', 'family_name'],
        ['phoneNum', 'phone_num'],
        ['dateOfBirth', 'date_of_birth'],
        ['createdDate', 'created_date'],
        ['profilePhotoPath', 'profile_photo'],
        ['password', 'password']),
      ]);
      try {
        const correctColumn = columns.get(userColumn);
        resolve(correctColumn);
      } catch (e) {
        reject(e);
      }
    });
  }
}

module.exports = User;
