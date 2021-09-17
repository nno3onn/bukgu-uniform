const express = require("express");
const router = express.Router();

const signin = require("router/api/admin/signin");
const verifyToken = require("router/api/admin/verifyToken");

router.use("/signin", signin);
router.use("/verifyToken", verifyToken);

module.exports = router;
