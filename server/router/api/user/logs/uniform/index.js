const express = require("express");
const router = express.Router();

const donate = require("router/api/user/logs/uniform/donate");
const purchase = require("router/api/user/logs/uniform/purchase");
const cart = require("router/api/user/logs/uniform/cart");

router.use("/donate", donate);
router.use("/purchase", purchase);
router.use("/cart", cart);

module.exports = router;
