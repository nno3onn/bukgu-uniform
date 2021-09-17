const express = require("express");
const UserModel = require("models/user");

const isMineOrAdmin = require("middlewares/auth/isMineOrAdmin");

const router = express.Router();

router.put("/", isMineOrAdmin, async (req, res) => {
  const { targetUid } = req.query;
  const { total, uniformCart, uniformShop, uniformDonate } = req.body;

  try {
    const updated = {};
    if (total === 0 || total) updated["alarms.total"] = total;
    if (uniformCart === 0 || uniformCart)
      updated["alarms.uniformCart"] = uniformCart;
    if (uniformShop === 0 || uniformShop)
      updated["alarms.uniformShop"] = uniformShop;
    if (uniformDonate === 0 || uniformDonate)
      updated["alarms.uniformDonate"] = uniformDonate;

    await UserModel.updateOne({ _id: targetUid }, updated);

    res.status(200).json({ success: true });
  } catch (err) {
    console.log(err);
    res.status(500).json({ success: false, message: "server error" });
  }
});

module.exports = router;
