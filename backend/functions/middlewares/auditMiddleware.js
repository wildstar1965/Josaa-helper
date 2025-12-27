const admin = require("firebase-admin");
const db = admin.firestore();

exports.audit = (action) => async (req, res, next) => {
  await db.collection("audit_logs").add({
    action,
    time: admin.firestore.FieldValue.serverTimestamp(),
    ip: req.ip,
  });

  next();
};
