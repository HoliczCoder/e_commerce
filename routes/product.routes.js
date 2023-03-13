var express = require("express");
var router = express.Router();

const { createProduct, updateProduct } = require("../controller/product.controller");

router.post("/", createProduct);
router.put("/", updateProduct)

module.exports = router;
