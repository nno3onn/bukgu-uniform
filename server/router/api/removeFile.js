const express = require("express");
const fs = require("fs");
const path = require("path");

const router = express.Router();

let data;

router.delete("/:file", async (req, res) => {
  try {
    const fileName = req.params.file;

    if (!fileName) {
      res.json({
        success: false,
        error: "files undefined",
      });
    }

    const filePath = `./uploads/${fileName}`;

    fs.access(filePath, fs.constants.F_OK, (err) => {
      if (err) return console.log(err);
      data = err;

      fs.unlink(filePath, (err) => {
        console.log(err ? err : `${fileName}를 정상적으로 삭제했습니다.`);
      });
    });

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
