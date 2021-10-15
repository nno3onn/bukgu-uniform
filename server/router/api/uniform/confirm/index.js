const express = require("express");

const router = express.Router();

const delivery = require("router/api/uniform/confirm/delivery");
const donate = require("router/api/uniform/confirm/donate");
const purchase = require("router/api/uniform/confirm/purchase");

router.use("/delivery", delivery);
router.use("/donate", donate);
router.use("/purchase", purchase);

module.exports = router;
