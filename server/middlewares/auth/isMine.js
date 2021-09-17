const jwt = require("jsonwebtoken");
const { USER_JWT_KEY } = require("configs/preset");

const isMine = async (req, res, next) => {
  try {
    const { targetUid } = req.query;

    const token = req.headers["x-access-token"];

    const decoded = jwt.verify(token, USER_JWT_KEY);

    if (decoded.userId === targetUid) next();
    else res.status(403).json({ success: false, error: "permission denied" });
  } catch (err) {
    res.status(403).json({ success: false, error: "permission denied" });
  }
};

module.exports = isMine;
