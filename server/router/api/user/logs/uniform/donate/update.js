const express = require("express");
const jwt = require("jsonwebtoken");

const UserLogModel = require("models/userLog");
const isUserOrAdmin = require("middlewares/auth/isUserOrAdmin");

const router = express.Router();

router.put("/", isUserOrAdmin, async (req, res) => {
  try {
    const token = req.headers["x-access-token"];
    const { userId } = jwt.decode(token);
    const { uniformId, title, thumbnail, status, showStatus, why } = req.body;

    const updated = {};
    if (title) updated["title"] = title;
    if (thumbnail) updated["thumbnail"] = thumbnail;
    if (status) updated["status"] = status;
    if (showStatus) updated["showStatus"] = showStatus;
    if (why) updated["why"] = why;

    console.log(updated);

    await UserLogModel.findOneAndUpdate(
      { ownerId: userId, type: "donate", uniformId },
      updated
    );

    res.status(200).json({
      success: true,
    });
  } catch (err) {
    console.log(err);
    res.status(500).json({
      success: false,
      error: "server error",
    });
  }
});

module.exports = router;
