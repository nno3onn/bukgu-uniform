const express = require("express");
const router = express.Router();

const list = require("router/api/user/logs/uniform/purchase/list");
const create = require("router/api/user/logs/uniform/purchase/create");

router.use("/", list);
router.use("/", create);

module.exports = router;
