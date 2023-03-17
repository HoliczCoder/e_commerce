var express = require("express");
var router = express.Router();
const {
  addMineCartItem,
  removeMineCartItem,
} = require("../controller/cart.controller");
const customerTokenVerify = require("../middleware/customerTokenVerify");
const detectCurrentCart = require("../middleware/detectCurrentCart");

router.post("/add-item", customerTokenVerify, detectCurrentCart, addMineCartItem);

router.delete("/delete-item", customerTokenVerify, detectCurrentCart, removeMineCartItem);

module.exports = router;
