var express = require("express");
var router = express.Router();
const { addMineCartItem } = require("../controller/cart.controller");
const customerTokenVerify = require("../middleware/customerTokenVerify");

router.post("/add-item", customerTokenVerify, addMineCartItem);

module.exports = router;
