const express = require("express");
const fs = require("fs");

const router = express.Router();

router.delete("/:file", async (req, res) => {
  try {
    const fileName = req.params.file;

    if (!fileName) {
      res.status(501).json({
        success: false,
        error: "files undefined",
      });
    }

    const filePath = `./uploads/${fileName}`;
    fs.unlinkSync(filePath);

    res.status(200).send({
      success: true,
      data: fileName,
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
