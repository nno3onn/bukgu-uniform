const express = require("express");
const mongoose = require("mongoose");
const InfoModel = require("models/info");

const router = express.Router();

router.get("/", async (req, res) => {
  const info = await InfoModel.findOne();
  res.status(200).json(info);
});

module.exports = router;
