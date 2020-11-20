const Item = require('./Item');

class RecurringItem extends Item {
  constructor(id, title, description, owner, paymentDay, timeFrame) {
    super(id, title, description, owner);
    this.paymentDay = paymentDay;
    this.timeFrame = timeFrame;
  }

  getPaymentDay() {
    return this.paymentDay;
  }

  setPaymentDay(paymentDay) {
    this.paymentDay = paymentDay;
  }

  getTimeframe() {
    return this.timeFrame;
  }

  setTimefame(timeFrame) {
    this.timeFrame = timeFrame;
  }
}

module.exports = RecurringItem;
