const express = require("express");
const jwt = require("jsonwebtoken");
const { ADMIN_JWT_KEY } = require("configs/preset");
const isAdmin = require("middlewares/auth/isAdmin");

const router = express.Router();

router.get("/", isAdmin, async (req, res) => {
  const token = req.headers["x-access-token"];
  const decoded = jwt.verify(token, ADMIN_JWT_KEY);

  if (decoded && decoded.userType === "admin" && decoded.exp > 0) {
    res.status(200).json({
      data: {
        userType: decoded.userType,
      },
    });
  } else {
    res.status(403).json({ success: false, message: "permision error" });
  }
});

module.exports = router;
