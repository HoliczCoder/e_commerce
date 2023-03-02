const express = require("express");
const usersRoutes = require("./users.routes");
const attributeRoutes = require("./attribute.routes")

const router = express.Router();

router.use("/users", usersRoutes);

router.use("/attribute", attributeRoutes)

module.exports = router;
