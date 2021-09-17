const express = require("express");
const router = express.Router();

const _delete = require("router/api/uniform/delete");
const update = require("router/api/uniform/update");
const list = require("router/api/uniform/list");
const getData = require("router/api/uniform/getData");
const requestDonate = require("router/api/uniform/requestDonate");
const confirmDonate = require("router/api/uniform/confirmDonate");
const searchRecord = require("router/api/uniform/searchRecord");
const confirmPurchase = require("router/api/uniform/confirmPurchase");
const confirmDelivery = require("router/api/uniform/confirmDelivery");
const rejectPurchase = require("router/api/uniform/rejectPurchase");
const requestPurchase = require("router/api/uniform/requestPurchase");

router.use("/delete", _delete);
router.use("/update", update);
router.use("/list", list);
router.use("/getData", getData);
router.use("/request/donate", requestDonate);
router.use("/confirm/donate", confirmDonate);
router.use("/confirm/purchase", confirmPurchase);
router.use("/searchRecord", searchRecord);
router.use("/confirm/delivery", confirmDelivery);
router.use("/reject/purchase", rejectPurchase);
router.use("/request/purchase", requestPurchase);

module.exports = router;
