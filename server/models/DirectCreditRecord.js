const DirectDebitType = require("./DirectDebitType")

class DirectCreditRecord {
    directCreditRecordID
    amountRecieved
    owner
    directCreditID
    directCreditRecordTitle
    directCreditRecordDescription
    recievedPaymentDate
    directCreditRecordLastUpdated
    directCreditTypeID
    timeframeID
    paymentDayID
    userComfirmedPayment
    directCreditRecordPayee
}

module.exports = DirectCreditRecord;