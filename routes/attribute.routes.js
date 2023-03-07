var express = require("express");
var router = express.Router();
const {
  createAttributeGroup,
  createAttribute,
  updateAttribute,
  deleteAttribute,
  deleteAttributeGroup,
} = require("../controller/attribute.controller");
const customerTokenVerify = require("../middleware/customerTokenVerify");

router.post("/", createAttribute);
router.put("/", updateAttribute);
router.delete("/", deleteAttribute);

router.post("/attribute-group", createAttributeGroup);
router.delete("/attribute-group", deleteAttributeGroup);

module.exports = router;
