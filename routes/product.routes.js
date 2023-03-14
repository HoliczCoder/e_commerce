var express = require("express");
var router = express.Router();

const {
  createProduct,
  updateProduct,
  deleteProduct,
  getProduct,
  getAllProduct,
} = require("../controller/product.controller");

router.get("/find-all", getAllProduct);
router.get("/", getProduct);
router.post("/", createProduct);
router.put("/", updateProduct);
router.delete("/", deleteProduct);

module.exports = router;
