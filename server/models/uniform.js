const mongoose = require("mongoose");

const modelName = "uniform";
const modelSchema = mongoose.Schema({
  uniformId: { type: String },
  title: { type: String },
  dateDelivery: { type: Number },
  dateShop: { type: Number },
  dateStock: { type: Number },
  code: { type: String },
  "filter-clothType": [{ type: String }],
  "filter-gender": { type: String },
  "filter-school": { type: String },
  "filter-season": { type: String },
  giverAddress: { type: String },
  giverDeliveryType: { type: String },
  giverName: { type: String },
  giverPhone: { type: String },
  giverUid: { type: String },
  images: [{ type: String }],
  receiverAddress: { type: String },
  receiverBirth: { type: String },
  receiverCert: [{ type: String }],
  receiverDeliveryType: { type: String },
  receiverName: { type: String },
  receiverPhone: { type: String },
  receiverSchool: { type: String },
  receiverUid: { type: String },
  status: { type: String },
  uniforms: [
    {
      clothType: { type: String },
      gender: { type: String },
      season: { type: String },
      school: { type: String },
      size: { type: String },
    },
  ],
});

const model = mongoose.model(modelName, modelSchema);

module.exports = model;
