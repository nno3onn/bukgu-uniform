const express = require("express");

const InfoModel = require("models/info");
const isUserOrAdmin = require("middlewares/auth/isUserOrAdmin");

const router = express.Router();

router.post("/", isUserOrAdmin, async (req, res) => {
  console.log("info update req.body", req.body);
  try {
    const {
      totalStock,
      totalBeforeDelivery,
      totalBeforeShop,
      totalDonate,
      totalBeforeStock,
      totalShopped,
      totalSchool,
    } = req.body;

    const updated = {};
    if (totalStock) updated["totalStock"] = totalStock;
    if (totalBeforeDelivery)
      updated["totalBeforeDelivery"] = totalBeforeDelivery;
    if (totalBeforeShop) updated["totalBeforeShop"] = totalBeforeShop;
    if (totalDonate) updated["totalDonate"] = totalDonate;
    if (totalBeforeStock) updated["totalBeforeStock"] = totalBeforeStock;
    if (totalShopped) updated["totalShopped"] = totalShopped;
    if (totalSchool)
      updated[`${totalSchool[0]}.${totalSchool[1]}.${totalSchool[2]}`] =
        totalSchool[3];

    await InfoModel.updateOne(
      {},
      {
        $inc: updated,
      }
    );

    res.status(200).json({
      success: true,
    });
  } catch (err) {
    console.log(err);
    res.status(500).json({
      success: false,
      error: "permission denied",
    });
  }
});

module.exports = router;
