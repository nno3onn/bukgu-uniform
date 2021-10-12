const express = require("express");
const isUserOrAdmin = require("middlewares/auth/isUserOrAdmin");
const UniformModel = require("models/uniform");

const router = express.Router();

router.get("/", isUserOrAdmin, async (req, res) => {
  try {
    // console.log(req.query);
    const {
      gender = null,
      clothType = null,
      school = null,
      season = null,
      keyword = null,
      status = null,
      giverDeliveryType = null,
      receiverDeliveryType = null,
    } = req.query;

    const conditions = {};
    const andQuery = [];

    if (gender !== null) andQuery.push({ "filter-gender": gender });
    if (clothType && JSON.parse(clothType).length)
      andQuery.push({
        "filter-clothType": {
          $in: JSON.parse(clothType),
        },
      });
    if (school !== null) andQuery.push({ "filter-school": school });
    if (season !== null) andQuery.push({ "filter-season": season });
    if (keyword !== null)
      andQuery.push({
        $or: [
          { title: new RegExp(keyword, "i") },
          { "filter-school": new RegExp(keyword, "i") },
          { "filter-gender": new RegExp(keyword, "i") },
          { "filter-season": new RegExp(keyword, "i") },
          { giverAddress: new RegExp(keyword, "i") },
          { giverPhone: new RegExp(keyword, "i") },
          { giverDeliveryType: new RegExp(keyword, "i") },
          { giverName: new RegExp(keyword, "i") },
          { receiverAddress: new RegExp(keyword, "i") },
          { receiverPhone: new RegExp(keyword, "i") },
          { receiverDeliveryType: new RegExp(keyword, "i") },
          { receiverName: new RegExp(keyword, "i") },
        ],
      });
    if (status !== null) andQuery.push({ status });
    if (giverDeliveryType !== null) andQuery.push({ giverDeliveryType });
    if (receiverDeliveryType !== null) andQuery.push({ receiverDeliveryType });

    if (andQuery.length > 0) conditions["$and"] = andQuery;

    const lists = await UniformModel.find(conditions);
    // console.log(lists);

    res.status(200).json({
      success: true,
      data: lists,
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
