const admin = require("firebase-admin");
const UserModel = require("models/user");

const shopUniformPush = async ({
  targetUid,
  confirm,
  uniformId,
  school,
  season,
}) => {
  try {
    const user = await UserModel.findOne({
      _id: targetUid,
    });

    const message = {
      notification: {
        title: `교복 구매 ${confirm} 안내`,
        body: `회원님이 구매요청하신 ${school} ${season}이 ${confirm}되었습니다`,
      },
      data: {
        confirm: confirm === "승인" ? "true" : "false",
        uniformId,
      },
      token: user.fcm,
    };

    await admin.messaging().send(message);
  } catch (err) {
    console.log(err);
  }
};

module.exports = shopUniformPush;
