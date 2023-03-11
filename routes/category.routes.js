var express = require("express");
const router = express.Router();

const { createCategory } = require("../controller/category.controller");

router.post("/", createCategory);

module.exports = router;
