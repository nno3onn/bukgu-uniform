const express = require("express");

const router = express.Router();

const add = require("router/api/user/logs/uniform/cart/add");
const list = require("router/api/user/logs/uniform/cart/list");
const remove = require("router/api/user/logs/uniform/cart/remove");

router.use("/", add);
router.use("/", list);
router.use("/", remove);

module.exports = router;
