const express = require("express");
const jwt = require("jsonwebtoken");

const UserLogModel = require("models/userLog");

const isUser = require("middlewares/auth/isUser");

const router = express.Router();

router.get("/", isUser, async (req, res) => {
  try {
    const token = req.headers["x-access-token"];
    const { userId } = jwt.decode(token);

    const lists = await UserLogModel.find({ ownerId: userId, type: "cart" });

    res.status(200).json({
      data: lists,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      error: "server error"
    });
  }
});

module.exports = router;
