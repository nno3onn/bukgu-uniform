const express = require("express");

const router = express.Router();

const purchase = require("router/api/uniform/reject/purchase");

router.use("/purchase", purchase);

module.exports = router;
