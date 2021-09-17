const express = require("express");
const router = express.Router();

const list = require("router/api/user/logs/uniform/donate/list");
const create = require("router/api/user/logs/uniform/donate/create");
const update = require("router/api/user/logs/uniform/donate/update");

router.use("/list", list);
router.use("/create", create);
router.use("/update", update);

module.exports = router;
