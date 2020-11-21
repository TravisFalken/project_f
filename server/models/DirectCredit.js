const RecurringItem = require('./RecurringItem');

class DirectCredit extends RecurringItem {
  constructor(
    id,
    title,
    description,
    owner,
    amount,
    totalAmountRecieved,
    directCreditType,
    account,
    paymentDay,
    timeFrame,
    createdDate,
    lastUpdated,
    payee
  ) {
    super(id, title, description, owner, paymentDay, timeFrame);
    this.amount = amount;
    this.totalAmountRecieved = totalAmountRecieved;
    this.directCreditType = directCreditType;
    this.account = account;
    this.createdDate = createdDate;
    this.lastUpdated = lastUpdated;
    this.payee = payee;
  }

  getAmount() {
    return this.amount;
  }

  setAmount(amount) {
    this.amount = amount;
  }

  getTotalAmountRecieved() {
    return this.totalAmountRecieved;
  }

  setTotalAmountRecieved(totalAmountRecieved) {
    this.totalAmountRecieved = totalAmountRecieved;
  }

  getDirectCreditType() {
    return this.directCreditType;
  }

  setDirectCreditType(directCreditType) {
    this.directCreditType = directCreditType;
  }

  getAccount() {
    return this.account;
  }

  setAccount(account) {
    this.account = account;
  }

  getCreatedDate() {
    return this.createdDate;
  }

  setCreatedDate(createdDate) {
    this.createdDate = createdDate;
  }

  getLastUpdated() {
    return this.lastUpdated;
  }

  setLastUpdated(lastUpdated) {
    this.lastUpdated = lastUpdated;
  }

  getPayee() {
    return this.payee;
  }

  setPayee(payee) {
    this.payee = payee;
  }

  static async getColumn(userColumn) {
    return new Promise(async (resolve, reject) => {
      const columns = new Map([
        ['id', 'direct_credit_id'],
        ['title', 'direct_credit_title'],
        ['description', 'direct_credit_description'],
        ['amount', 'direct_credit_amount'],
        ['owner', 'owner'],
        ['totalAmountRecieved', 'total_amount_recieved'],
        ['directCreditType', 'direct_credit_type_id'],
        ['accountID', 'account_id'],
        ['timeframe', 'timeframe_id'],
        ['paymentDay', 'payment_day_id'],
        ['createdDate', 'direct_credit_created_date'],
        ['lastUpdated', 'direct_credit_last_updated'],
        ['payee', 'payee'],
      ]);
      try {
        const res = columns.get(userColumn);
        resolve(res);
      } catch (e) {
        reject(e);
      }
    });
  }
}

module.exports = DirectCredit;
