const express = require("express");
const fs = require("fs");
const path = require("path");

const isAdmin = require("middlewares/auth/isAdmin");
const UniformModel = require("models/uniform");

const router = express.Router();

router.get("/", isAdmin, async (req, res) => {
  try {
    const { uniformId } = req.query;

    const uniform = await UniformModel.findOne({ uniformId });
    if (uniform === null) new Error("no exist uniform");
    else {
      await UniformModel.deleteOne({ uniformId });
      // if (uniform.images.length) {
      //   uniform.images.forEach((filename) => {
      //     const filePath = path.join(__dirname, "../../../", filename);
      //     fs.unlinkSync(filePath);
      //   });
      // }
    }

    res.status(200).json({ success: true });
  } catch (err) {
    console.log(err);
    res.status(500).json({
      success: false,
      error: "server error",
    });
  }
});

module.exports = router;
