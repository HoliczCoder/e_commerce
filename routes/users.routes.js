var express = require("express");
var router = express.Router();
const {createCustomer} = require("../controller/user.controller");
const {createCustomerSession} = require("../controller/user.controller")
const customerTokenVerify = require("../middleware/customerTokenVerify")


/* GET users listing. */
router.get("/", function (req, res, next) {
  res.send("respond with a resource");
});

router.post("/", createCustomer);

router.post("/login", customerTokenVerify , createCustomerSession);

module.exports = router;
