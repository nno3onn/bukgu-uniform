const express = require("express");

const isUserOrAdmin = require("middlewares/auth/isUserOrAdmin");
const UniformModel = require("models/uniform");
const UniformTransferRecordModel = require("models/uniformTransferRecord");

const router = express.Router();

router.put("/", isUserOrAdmin, async (req, res) => {
  try {
    const { uniformId } = req.query;

    const {
      receiverUid,
      receiverName,
      receiverPhone,
      receiverAddress,
      receiverDeliveryType,
      receiverCert,
      receiverBirth,
      receiverSchool,
      status,
      dateShop,
      uniforms,
      season,
      gender,
    } = req.body;

    const updated = {
      receiverUid,
      receiverName,
      receiverPhone,
      receiverAddress,
      receiverDeliveryType,
      receiverBirth,
      receiverSchool,
      status,
      dateShop,
    };

    if (receiverCert && receiverCert.length)
      updated["receiverCert"] = receiverCert;

    const uniform = await UniformModel.findOne({ uniformId });
    if (uniform === null) new Error("non exist uniform");

    const newRecord = new UniformTransferRecordModel({
      uniformId,
      userId: receiverUid,
      name: receiverName,
      birth: receiverBirth,
      school: receiverSchool,
      cert: receiverCert && receiverCert.length ? receiverCert : [],
      confirm: "승인",
      uniforms,
      season,
      gender,
    });

    await Promise.all([
      UniformModel.updateOne({ uniformId }, updated),
      newRecord.save(),
    ]);

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
