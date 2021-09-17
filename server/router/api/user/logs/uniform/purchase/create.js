const express = require("express");
const jwt = require("jsonwebtoken");

const UserLogModel = require("models/userLog");

const isUser = require("middlewares/auth/isUser");

const router = express.Router();

router.post("/", isUser, async (req, res) => {
  try {
    const token = req.headers["x-access-token"];

    const { userId } = jwt.decode(token);

    const { uniformId, title, thumbnail, status, showStatus } = req.body;

    const newLog = new UserLogModel({
      ownerId: userId,
      type: "purchase",
      uniformId,
      title,
      thumbnail,
      status,
      showStatus,
    });

    const _log = await newLog.save();

    console.log(_log.id);

    res.status(200).json({
      success: true,
      data: _log.id,
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
