var express = require("express");
var router = express.Router();
const {createAttributeGroup, createAttribute} = require("../controller/attribute.controller")
const customerTokenVerify = require("../middleware/customerTokenVerify")


router.post("/", createAttribute)
router.post("/attribute-group", createAttributeGroup);

module.exports = router;
