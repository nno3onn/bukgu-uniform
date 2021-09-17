const express = require("express");

const router = express.Router();

const add = require("router/api/user/logs/uniform/cart/add");
const list = require("router/api/user/logs/uniform/cart/list");
const remove = require("router/api/user/logs/uniform/cart/remove");

router.use("/add", add);
router.use("/list", list);
router.use("/remove", remove);

module.exports = router;
