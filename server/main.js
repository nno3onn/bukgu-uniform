require("app-module-path").addPath(`${__dirname}`);

const express = require("express");
const path = require("path");
const bodyParser = require("body-parser");
const multer = require("multer");
const mongoose = require("mongoose");
const cors = require("cors");
const admin = require("firebase-admin");
const serviceAccount = require("./admin.json");
const router = require("router");

const main = async () => {
  const pwd = "6331";
  const uri = `mongodb+srv://dbUser:${pwd}@su-2021.jcc4d.mongodb.net/su-2021-test?retryWrites=true&w=majority`;

  await mongoose
    .connect(uri, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
      useFindAndModify: false,
      useCreateIndex: true,
    })
    .then(() => console.log("MongoDB Connected ..."))
    .catch((error) => console.log(error));

  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
  });

  const app = express();
  app.use(cors());
  app.use(express.json());
  app.use(express.urlencoded({ extended: true }));
  // app.use(bodyParser.json());
  // app.use(bodyParser.urlencoded({extended:true}));
  app.use("/uploads", express.static("uploads"));
  app.use("/", router);

  app.listen(3001, () => {
    console.log("server on");
  });

  const {
    createJSONFiles,
    initInfo,
    initUser,
    inituniformTransferRecord,
    initUniform,
  } = require("./getInitData");

  // createJSONFiles();
  // initInfo();
  // initUniform();
  // initUser();
  // inituniformTransferRecord();
};

main();
