var express = require("express");
var router = express.Router();

const { createProduct } = require("../controller/product.controller");

router.post("/", createProduct);

module.exports = router;
