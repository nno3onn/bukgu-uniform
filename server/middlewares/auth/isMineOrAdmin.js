const jwt = require("jsonwebtoken");
const { ADMIN_JWT_KEY, USER_JWT_KEY } = require("configs/preset");

const isMineOrAdmin = async (req, res, next) => {
  try {
    const { targetUid } = req.query;
    const token = req.headers["x-access-token"];
    const { userType } = jwt.decode(token);
    const isTokenForAdmin = userType === "admin";

    if (isTokenForAdmin) {
      const decoded = jwt.verify(token, ADMIN_JWT_KEY);
      next();
    } else {
      const decoded = jwt.verify(token, USER_JWT_KEY);
      if (decoded.userId === targetUid) next();
      else res.status(403).json({ success: false, error: "permission denied" });
    }
  } catch (err) {
    res.status(403).json({ success: false, error: "permission denied" });
  }
};

module.exports = isMineOrAdmin;
