const express = require('express');
const { createUser, updatePassword } = require('../controllers/user');
const {protect} = require('../middleware/auth');

const router = express.Router();

router.route('/').post(createUser);
router.route('/updatePassword').put(protect,updatePassword);

module.exports = router;
