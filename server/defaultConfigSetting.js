require("app-module-path").addPath(`${__dirname}`);

const mongoose = require("mongoose");
const InfoModel = require("models/info");

const schools = require("data/school");

const setting = async () => {
  const pwd = "6331";
  const uri = `mongodb+srv://dbUser:${pwd}@su-2021.jcc4d.mongodb.net/su-2021-test?retryWrites=true&w=majority`;
  await mongoose.connect(uri, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useFindAndModify: false,
    useCreateIndex: true,
  });

  const middleSchools = {};
  const highSchools = {};
  schools.middleSchools.map((s) => {
    middleSchools[s] = {
      totalDonate: 0,
      totalShop: 0,
      totalStock: 0,
    };
  });

  schools.highSchools.map((s) => {
    highSchools[s] = {
      totalDonate: 0,
      totalShop: 0,
      totalStock: 0,
    };
  });

  const info = new InfoModel({
    centerAddress: "https://m.place.naver.com/place/12183810/home?entry=pll",
    centerPhone: "053-665-2288",
    highSchools,
    middleSchools,
    officePhone: "053-665-3962",
    officePhoneDonation: "053-665-3964",
    shouldBeUpdated: false,
    totalBeforeDelivery: 0,
    totalBeforeShop: 0,
    totalBeforeStock: 0,
    totalDonate: 0,
    totalStock: 0,
    updateMent: "",
  });

  await info.save();
  console.log("end");
};

setting();
