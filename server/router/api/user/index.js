const express = require("express");

const router = express.Router();

const getData = require("router/api/user/getData");
const signin = require("router/api/user/signin");
const update = require("router/api/user/update");
const logs = require("router/api/user/logs");

router.use("/getData", getData);
router.use("/signin", signin);
router.use("/update", update);
router.use("/logs", logs);

module.exports = router;
