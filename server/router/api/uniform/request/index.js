const express = require("express");

const router = express.Router();

const donate = require("router/api/uniform/request/donate");
const purchase = require("router/api/uniform/request/purchase");

router.use("/donate", donate);
router.use("/purchase", purchase);

module.exports = router;
