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

    uniform.status = "교복보유중";

    const updated = {
      totalDonate: 1,
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
      confirm: "교복보유중",
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
