const fs = require("fs");
const InfoModel = require("models/info");
const UserModel = require("models/user");
const UserLogModel = require("models/userLog");
const UniformModel = require("models/uniform");
const uniformTransferRecord = require("models/uniformTransferRecord");

const admin = require("firebase-admin");
const db = admin.firestore();

const writeJSONFile = (jsonData, filename) => {
  fs.writeFile(`${filename}.json`, JSON.stringify(jsonData), "utf8", (err) => {
    if (err) return console.error(err);
  });
};

const createJSONFiles = () => {
  ["infos", "users", "uniformTransferRecord", "uniforms"].map((type) => {
    readFirestoreData(type);
  });
};

const readFirestoreData = async (type) => {
  const getData = db.collection("daegu").doc("bukgu");

  let data;
  switch (type) {
    case "infos":
      data = await getData.get();
      data = data["_fieldsProto"];
      break;
    case "users":
      data = await getData.collection(type).get();
      data.docs.map((doc) => {
        doc["_id"] = doc.id;
      });
      break;
    case "uniformTransferRecord":
      data = await getData.collection("logs").get();
      data = data.docs;
      break;
    case "uniforms":
      data = await getData.collection(type).get();
      data = data.docs;
      break;
  }
  writeJSONFile(data, type);
};

const readJSONFile = (fileName) => {
  const data = fs.readFileSync(fileName + ".json", "utf8");
  return JSON.parse(data);
};

const initInfo = async () => {
  const doc = readJSONFile("infos");

  let highSchools = new Object();
  let middleSchools = new Object();

  const highSchoolDatas = doc.highSchool.mapValue.fields;
  const middleSchoolDatas = doc.middleSchool.mapValue.fields;

  [highSchoolDatas, middleSchoolDatas].map((schoolLevel, index) => {
    for ([school, schoolValue] of Object.entries(schoolLevel)) {
      let totalThings = new Object();
      for ([total, totalValue] of Object.entries(schoolValue.mapValue.fields)) {
        totalThings[total] = Number(totalValue.integerValue);
      }
      index === 0
        ? (highSchools[school] = totalThings)
        : (middleSchools[school] = totalThings);
    }
  });

  InfoModel.create({
    highSchools,
    middleSchools,
    centerAddress: doc.centerAddress.stringValue,
    centerPhone: doc.centerPhone.stringValue,
    officePhone: doc.officePhone.stringValue,
    officePhoneDonation: doc.officePhoneDonation.stringValue,
    shouldBeUpdated: doc.shouldBeUpdated.booleanValue,
    totalBeforeDelivery: doc.totalBeforeDelivery.integerValue,
    totalBeforeShop: doc.totalBeforeShop.integerValue,
    totalBeforeStock: doc.totalBeforeStock.integerValue,
    totalDonate: doc.totalDonate.integerValue,
    totalShopped: doc.totalShopped.integerValue,
    totalStock: doc.totalStock.integerValue,
    updateMent: doc.updateMent.stringValue,
  });
};

const initUser = async () => {
  const docs = readJSONFile("users")["_materializedDocs"];

  docs.map((doc) => {
    const docDatas = doc["_fieldsProto"];

    const fcm = docDatas.fcm ? docDatas.fcm.stringValue : null;

    UserModel.create({
      _id: doc["_id"],
      fcm,
      alarms: {
        total: docDatas.totalAlarms.integerValue,
        uniformCart: docDatas.totalAlarmsCart.integerValue,
        uniformDonate: docDatas.totalAlarmsDonate.integerValue,
        uniformShop: docDatas.totalAlarmsShop.integerValue,
      },
    });
  });
};

const inituniformTransferRecord = async () => {
  const docs = readJSONFile("uniformTransferRecord");

  docs.map((doc) => {
    doc = doc["_fieldsProto"];

    const cert = doc.cert.arrayValue.values.map((value) => {
      return value.stringValue;
    });
    const uniforms = doc.uniforms.arrayValue.values.map((value) => {
      let obj = new Object();
      obj.clothType = value.mapValue.fields.clothType.stringValue;
      obj.size = value.mapValue.fields.size.stringValue;
      return obj;
    });

    uniformTransferRecord.create({
      birth: doc.birth.stringValue,
      cert,
      confirm: doc.confirm.stringValue,
      gender: doc.gender.stringValue,
      name: doc.name.stringValue,
      school: doc.school.stringValue,
      season: doc.season.stringValue,
      userId: doc.uid.stringValue,
      uniformId: doc.uniformId.stringValue,
      uniforms,
    });
  });
};

const initUniform = async () => {
  const docs = readJSONFile("uniforms");

  // const doc = docs[1]["_fieldsProto"];
  // console.log(doc);
  docs.map((doc) => {
    doc = doc["_fieldsProto"];

    const filterClothType = doc["filter-clothType"].arrayValue.values.map(
      (value) => {
        return value.stringValue;
      }
    );

    const images = doc["images"].arrayValue.values.map((value) => {
      return value.stringValue;
    });

    const receiverCert = doc["receiverCert"]
      ? doc["receiverCert"].arrayValue.values.map((value) => {
          return value.stringValue;
        })
      : null;

    const uniforms = doc["uniforms"].arrayValue.values.map((value) => {
      let obj = new Object();
      const fields = value.mapValue.fields;
      obj.gender = fields.gender.stringValue;
      obj.school = fields.school.stringValue;
      obj.clothType = fields.clothType.stringValue;
      obj.size = fields.size.stringValue;
      obj.season = fields.season.stringValue;
      return obj;
    });
    // console.log(doc["filter-clothType"].arra);
    const filterclothType = doc["filter-clothType"].arrayValue.values.map(
      (value) => {
        return value.stringValue;
      }
    );
    const filtergender = doc["filter-gender"].stringValue;
    const filterschool = doc["filter-school"].stringValue;
    const filterseason = doc["filter-season"].stringValue;
    const title =
      `${filtergender} / ${filterseason} -` +
      uniforms
        .map((uniform) => {
          return ` ${uniform.clothType} (사이즈: ${uniform.size})`;
        })
        .toString();

    UniformModel.create({
      uniformId: doc.code.stringValue,
      title,
      dateDelivery: doc.dateDelivery ? doc.dateDelivery.integerValue : null,
      dateShop: doc.dateShop ? doc.dateShop.integerValue : null,
      dateStock: doc.dateStock ? doc.dateStock.integerValue : null,
      code: doc.code.stringValue,
      "filter-clothType": filterclothType,
      "filter-gender": filtergender,
      "filter-school": filterschool,
      "filter-season": filterseason,
      giverAddress: doc.giverAddress ? doc.giverAddress.stringValue : null,
      giverDeliveryType: doc.giverDeliveryType.stringValue,
      giverName: doc.giverName.stringValue,
      giverPhone: doc.giverPhone.stringValue,
      giverUid: doc.giverUid.stringValue,
      images,
      receiverAddress: doc.receiverAddress
        ? doc.receiverAddress.stringValue
        : null,
      receiverBirth: doc.receiverBirth ? doc.receiverBirth.stringValue : null,
      receiverCert,
      receiverDeliveryType: doc.receiverDeliveryType
        ? doc.receiverDeliveryType.stringValue
        : null,
      receiverName: doc.receiverName ? doc.receiverName.stringValue : null,
      receiverPhone: doc.receiverPhone ? doc.receiverPhone.stringValue : null,
      receiverSchool: doc.receiverSchool
        ? doc.receiverSchool.stringValue
        : null,
      receiverUid: doc.receiverUid ? doc.receiverUid.stringValue : null,
      status: doc.status ? doc.status.stringValue : null,
      uniforms,
    });
  });
  // docs.map((doc) => {
  //   doc = doc["_fieldsProto"];
  //   let filterclothType = new Array();
  //   doc["filter-clothType"].arrayValue.values.map((value) => {
  //     filterclothType.push(value.stringValue);
  //   });
  //   const filtergender = doc["filter-gender"]
  //     ? doc["filter-gender"].stringValue
  //     : null;
  //   const filterschool = doc["filter-school"]
  //     ? doc["filter-school"].stringValue
  //     : null;
  //   const filterseason = doc["filter-season"]
  //     ? doc["filter-season"].stringValue
  //     : null;
  //   const uniformId = doc.code.stringValue;
  //   const code = uniformId;
  //   const dateDelivery = doc.dateDelivery
  //     ? doc.dateDelivery.integerValue
  //     : null;
  //   const dateShop = doc.dateShop ? doc.dateShop.integerValue : null;
  //   const dateStock = doc.dateStock ? doc.dateStock.integerValue : null;
  //   const giverAddress = doc.giverAddress ? doc.giverAddress.stringValue : null;
  //   const giverDeliveryType = doc.giverDeliveryType
  //     ? doc.giverDeliveryType.stringValue
  //     : null;
  //   const giverName = doc.giverName ? doc.giverName.stringValue : null;
  //   const giverPhone = doc.giverPhone ? doc.giverPhone.stringValue : null;
  //   const giverUid = doc.giverUid ? doc.giverUid.stringValue : null;
  //   let images = new Array();
  //   doc.images.arrayValue.values.map((value) => {
  //     images.push(value.stringValue);
  //   });
  //   const receiverAddress = doc.receiverAddress
  //     ? doc.receiverAddress.stringValue
  //     : null;
  //   const receiverBirth = doc.receiverBirth
  //     ? doc.receiverBirth.stringValue
  //     : null;
  //   const receiverCert = doc.receiverCert ? doc.receiverCert.stringValue : null;
  //   const receiverDeliveryType = doc.receiverDeliveryType
  //     ? doc.receiverDeliveryType.stringValue
  //     : null;
  //   const receiverName = doc.receiverName ? doc.receiverName.stringValue : null;
  //   const receiverPhone = doc.receiverPhone
  //     ? doc.receiverPhone.stringValue
  //     : null;
  //   const receiverSchool = doc.receiverSchool
  //     ? doc.receiverSchool.stringValue
  //     : null;
  //   const receiverUid = doc.receiverUid ? doc.receiverUid.stringValue : null;
  //   const status = doc.status ? doc.status.stringValue : null;

  //   let title = `${filtergender} / ${filterseason} - `;
  //   let uniforms = new Array();
  //   for (const type of doc.uniforms.arrayValue.values) {
  //     const uniformFields = type.mapValue.fields;
  //     const clothType = uniformFields.clothType.stringValue;
  //     const gender = uniformFields.gender.stringValue;
  //     const school = uniformFields.school.stringValue;
  //     const season = uniformFields.season.stringValue;
  //     const size = uniformFields.size.stringValue;
  //     uniforms.push({ clothType, gender, school, season, size });
  //     title += `${clothType} (사이즈: ${size}), `;
  //   }

  //   UniformModel.create({
  //     uniformId,
  //     title,
  //     dateDelivery,
  //     dateShop,
  //     dateStock,
  //     code,
  //     "filter-clothType": filterclothType,
  //     "filter-gender": filtergender,
  //     "filter-school": filterschool,
  //     "filter-season": filterseason,
  //     giverAddress,
  //     giverDeliveryType,
  //     giverName,
  //     giverPhone,
  //     giverUid,
  //     images,
  //     receiverAddress,
  //     receiverBirth,
  //     receiverCert,
  //     receiverDeliveryType,
  //     receiverName,
  //     receiverPhone,
  //     receiverSchool,
  //     receiverUid,
  //     status,
  //     uniforms,
  //   });
  // });
};

module.exports = {
  createJSONFiles,
  initInfo,
  initUser,
  inituniformTransferRecord,
  initUniform,
};
