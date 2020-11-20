class Item {
  constructor(id, title, description, owner) {
    this.id = id;
    this.title = title;
    this.description = description;
    this.ownerID = owner;
  }

  getID() {
    return this.id;
  }

  setID(id) {
    this.id = id;
  }

  getTitle() {
    return this.title;
  }

  setTitle(title) {
    this.title = title;
  }

  getDescription() {
    return this.description;
  }

  setDescription(description) {
    this.description = description;
  }
}

module.exports = Item;
