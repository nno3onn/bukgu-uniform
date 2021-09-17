const express = require("express");
const path = require("path");

const router = express.Router();

const multer = require("multer");

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./uploads");
  },
  filename: (req, file, cb) => {
    cb(null, file.originalname);
  },
});

// const fileFilter = (req, file, cb) => {
//   if (file.mimetype == "image/jpeg" || file.mimetype == "image/png") {
//     cb(null, true);
//   } else {
//     cb(null, false);
//   }
// };

const upload = multer({
  storage: storage,
  limits: {
    fileSize: 1024 * 1024 * 1,
  },
  // fileFilter: fileFilter,
});

router.post("/", upload.single("imageFile"), async (req, res) => {
  try {
    const file = req.file;
    console.log(req.file);

    if (!file) {
      res.json({
        success: false,
        error: "bad request",
      });
    }

    res.status(200).send({
      success: true,
      data: req.file.path,
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
