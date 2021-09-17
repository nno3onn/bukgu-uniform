const express = require("express");
const jwt = require("jsonwebtoken");

const { USER_JWT_KEY } = require("configs/preset");

const UserModel = require("models/user");

const router = express.Router();

router.post("/", async (req, res) => {
  try {
    const { fcm } = req.body;

    const user = new UserModel({
      fcm,
      alrams: {
        totalAlarms: 0,
        totalAlarmsDonate: 0,
        totalAlarmsShop: 0,
        totalAlarmsCart: 0,
      },
    });

    await user.save();

    const token = jwt.sign(
      {
        userType: "user",
        userId: user._id,
      },
      USER_JWT_KEY
    );

    res.status(200).json({ userId: user._id, token });
  } catch (e) {
    console.log(e);
  }
});

module.exports = router;
