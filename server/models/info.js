const mongoose = require("mongoose");

const modelName = "info";
const modelSchema = mongoose.Schema({
  centerAddress: { type: String },
  centerPhone: { type: String },
  highSchools: { type: Object },
  middleSchools: { type: Object },
  officePhone: { type: String },
  officePhoneDonation: { type: String },
  shouldBeUpdated: { type: Boolean },
  totalBeforeDelivery: { type: Number },
  totalBeforeShop: { type: Number },
  totalBeforeStock: { type: Number },
  totalDonate: { type: Number },
  totalShopped: { type: Number },
  totalStock: { type: Number },
  updateMent: { type: String },
});

const model = mongoose.model(modelName, modelSchema);

module.exports = model;
