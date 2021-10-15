const express = require("express");
const router = express.Router();

const UniformModel = require("models/uniform");
const InfoModel = require("models/info");

const isAdmin = require("middlewares/auth/isAdmin");
const shopUniformPush = require("utils/shopUniformPush");

router.put("/", isAdmin, async (req, res) => {
  try {
    const { uniformId } = req.query;

    const uniform = await UniformModel.findOne({ uniformId });
    if (uniform === null) throw new Error("non exist uniform");
    if (uniform.status !== "출고대기중") throw new Error("duplicated request");

    uniform.status = "최종완료";
    uniform.dateDelivery = new Date().getTime();

    const updated = {
      totalBeforeDelivery: -1,
      totalShopped: 1,
    };

    await Promise.all([
      uniform.save(),
      InfoModel.findOneAndUpdate(
        {},
        {
          $inc: updated,
        }
      ),
    ]);

    await shopUniformPush({
      targetUid: uniform.giverUid,
      confirm: "최종완료",
      uniformId: uniformId,
      school: uniform["filter-school"],
      season: uniform["filter-season"],
    });

    res.status(200).json({ success: true });
  } catch (err) {
    res.status(500).json({
      success: true,
      error: "server error",
    });
  }
});

module.exports = router;
