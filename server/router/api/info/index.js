const express = require("express");

const router = express.Router();

const getData = require("router/api/info/getData");
const update = require("router/api/info/update");

router.use("/getData", getData);
router.use("/update", update);

module.exports = router;
