const express = require("express");
const isUserOrAdmin = require("middlewares/auth/isUserOrAdmin");
const UniformModel = require("models/uniform");

const router = express.Router();

router.get("/", isUserOrAdmin, async (req, res) => {
  try {
    const { uniformId } = req.query;
    const uniform = await UniformModel.findOne({ uniformId });

    res.status(200).json({
      success: true,
      data: uniform,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      error: "server error",
    });
  }
});

module.exports = router;
