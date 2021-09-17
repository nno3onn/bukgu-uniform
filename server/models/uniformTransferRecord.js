const mongoose = require("mongoose");

const modelName = "uniformTransferRecord";
const modelSchema = mongoose.Schema({
  birth: { type: String },
  cert: [{ type: String }],
  confirm: { type: String },
  gender: { type: String },
  name: { type: String },
  school: { type: String },
  season: { type: String },
  userId: { type: String },
  uniformId: { type: String },
  uniforms: [
    {
      clothType: String,
      size: String,
    },
  ],
});

const model = mongoose.model(modelName, modelSchema);

module.exports = model;
