const mongoose = require("mongoose");

const modelName = "userLog";
const modelSchema = mongoose.Schema({
  ownerId: { type: String },
  type: { type: String },
  uniformId: { type: String },
  title: { type: String },
  thumbnail: { type: String },
  status: { type: String },
  showStatus: { type: String },
  why: { type: String },
});

const model = mongoose.model(modelName, modelSchema);

module.exports = model;
