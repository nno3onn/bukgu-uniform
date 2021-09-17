const express = require("express");
const router = express.Router();

const uniform = require("router/api/user/logs/uniform");

router.use("/uniform", uniform);

module.exports = router;
