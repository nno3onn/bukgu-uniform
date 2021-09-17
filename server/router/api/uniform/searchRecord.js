const express = require("express");
const isUserOrAdmin = require("middlewares/auth/isUserOrAdmin");
const uniformTransferRecordModel = require("models/uniformTransferRecord");

const router = express.Router();

router.get("/", async (req, res) => {
  try {
    const { nameKeyword, birthKeyword, sort = { dateStock: 1 } } = req.query;

    const conditions = {};
    const andQuery = [];

    andQuery.push({
      $or: [
        { name: new RegExp(nameKeyword, "i") },
        {
          birth: new RegExp(birthKeyword, "i"),
        },
      ],
    });

    if (andQuery.length > 0) conditions["$and"] = andQuery;

    const lists = await uniformTransferRecordModel.find(conditions).sort(sort);

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
