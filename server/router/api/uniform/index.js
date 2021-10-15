const express = require("express");
const router = express.Router();

const remove = require("router/api/uniform/remove");
const update = require("router/api/uniform/update");
const getData = require("router/api/uniform/getData");

const confirm = require("router/api/uniform/confirm");
const reject = require("router/api/uniform/reject");
const request = require("router/api/uniform/request");

const list = require("router/api/uniform/list");
const searchRecord = require("router/api/uniform/searchRecord");

router.use("/", remove);
router.use("/", update);
router.use("/", getData);

router.use("/confirm", confirm);
router.use("/reject", reject);
router.use("/request", request);

router.use("/list", list);
router.use("/searchRecord", searchRecord);

module.exports = router;
