const express = require("express");

const UniformModel = require("models/uniform");
const isUserOrAdmin = require("middlewares/auth/isUserOrAdmin");

const router = express.Router();

router.post("/", isUserOrAdmin, async (req, res) => {
  try {
    const {
      uniformId,
      totalImages,
      images,
      status,
      code,
      giverName,
      giverUid,
      giverPhone,
      giverAddress,
      giverDeliveryType,
      uniforms,
    } = req.body;

    const newUniform = new UniformModel({
      uniformId,
      totalImages,
      images,
      status,
      code,
      giverName,
      giverUid,
      giverPhone,
      giverAddress,
      giverDeliveryType,
      uniforms,
      "filter-school": req.body["filter-school"],
      "filter-gender": req.body["filter-gender"],
      "filter-season": req.body["filter-season"],
      "filter-clothType": req.body["filter-clothType"],
      title: `${req.body["filter-school"]} · ${req.body["filter-gender"]} · ${req.body["filter-season"]}`,
    });

    await newUniform.save();

    res.status(200).json({
      success: true,
      data: uniformId,
    });
  } catch (err) {
    console.log(err);
    res.status(500).json({
      success: false,
      error: "permission denied",
    });
  }
});

module.exports = router;
