const express = require("express");
const router = express.Router();

const jwt = require("jsonwebtoken");
const isAdmin = require("middlewares/auth/isAdmin");
const UniformModel = require("models/uniform");
const UniformTransferRecordModel = require("models/uniformTransferRecord");
const InfoModel = require("models/info");

router.put("/", isAdmin, async (req, res) => {
  try {
    const { uniformId } = req.query;
    const {
      uid,
      name,
      birth,
      school,
      cert,
      season,
      gender,
      uniforms,
      confirm,
    } = req.body;

    const uniform = await UniformModel.findOne({ uniformId });

    if (uniform === null) throw new Error("non exist uniform");
    if (uniform.status !== "구매승인요청")
      throw new Error("duplicated request");

    uniform.status = "교복보유중";

    const newRecord = new UniformTransferRecordModel({
      uniformId,
      userId: uid,
      name,
      birth,
      school,
      cert,
      season,
      gender,
      uniforms,
      confirm,
    });

    await Promise.all([
      uniform.save(),
      InfoModel.findOneAndUpdate(
        {},
        {
          $inc: {
            totalBeforeShop: -1,
            totalStock: 1,
          },
        }
      ),
      newRecord.save(),
    ]);

    res.status(200).json({
      success: true,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      error: "server error",
    });
  }
});

module.exports = router;
