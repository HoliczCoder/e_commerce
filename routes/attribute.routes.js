var express = require("express");
var router = express.Router();
const {
  createAttributeGroup,
  createAttribute,
  updateAttribute,
} = require("../controller/attribute.controller");
const customerTokenVerify = require("../middleware/customerTokenVerify");

router.post("/", createAttribute);
router.post("/attribute-group", createAttributeGroup);
router.put("/", updateAttribute);

module.exports = router;
