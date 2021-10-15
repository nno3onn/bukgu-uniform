// 구매승인
// 구매신청한 사람한테 승인됐다고 푸시 알람
// uniform 모델의 status 변경
// info model의 total count 변경
const express = require("express");
const router = express.Router();

const UniformModel = require("models/uniform");
const InfoModel = require("models/info");
const UniformTransferRecordModel = require("models/uniformTransferRecord");

const isAdmin = require("middlewares/auth/isAdmin");
const shopUniformPush = require("utils/shopUniformPush");

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

    uniform.status = "출고대기중";

    const updated = {
      totalBeforeShop: -1,
      totalBeforeDelivery: 1,
    };

    await Promise.all([
      uniform.save(),
      InfoModel.findOneAndUpdate(
        {},
        {
          $inc: updated,
        }
      ),
      UniformTransferRecordModel.findOneAndUpdate(
        {
          uniformId,
          userId: uid,
        },
        {
          name,
          birth,
          school,
          cert,
          season,
          gender,
          uniforms,
          confirm,
        }
      ),
    ]);

    await shopUniformPush({
      targetUid: uniform.giverUid,
      confirm: "출고대기중",
      uniformId: uniformId,
      school: uniform["filter-school"],
      season: uniform["filter-season"],
    });

    res.status(200).json({ success: true });
  } catch (err) {
    res.status(500).json({
      success: false,
      error: "server error",
    });
  }
});

module.exports = router;
