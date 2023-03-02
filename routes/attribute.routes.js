var express = require("express");
var router = express.Router();
const {createAttributeGroup} = require("../controller/attribute.controller")
const customerTokenVerify = require("../middleware/customerTokenVerify")


router.post("/attribute-group", createAttributeGroup);

module.exports = router;
