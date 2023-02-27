var express = require("express");
var router = express.Router();
const createCustomer = require("../controller/user.controller");

/* GET users listing. */
router.get("/", function (req, res, next) {
  res.send("respond with a resource");
});

router.post("/", createCustomer);

// router.post("/", createCustomer);

module.exports = router;
