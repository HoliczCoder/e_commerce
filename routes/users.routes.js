var express = require("express");
var router = express.Router();
const {
  createCustomer,
  createCustomerSession,
  deleteCustomerSession,
} = require("../controller/user.controller");
const customerTokenVerify = require("../middleware/customerTokenVerify");
const { route } = require("./cart.routes");

/* GET users listing. */
router.get("/", function (req, res, next) {
  res.send("respond with a resource");
});

router.post("/", createCustomer);

router.post("/login", createCustomerSession);

router.post("/logout", customerTokenVerify, deleteCustomerSession);

module.exports = router;
