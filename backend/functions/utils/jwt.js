const jwt = require("jsonwebtoken");

const ACCESS_SECRET = "dev-access-secret";
const REFRESH_SECRET = "dev-refresh-secret";

exports.signAccess = (data) =>
  jwt.sign(data, ACCESS_SECRET, { expiresIn: "15m" });

exports.signRefresh = (data) =>
  jwt.sign(data, REFRESH_SECRET, { expiresIn: "30d" });

exports.verifyAccess = (token) =>
  jwt.verify(token, ACCESS_SECRET);

exports.verifyRefresh = (token) => {
  try {
    return jwt.verify(token, REFRESH_SECRET);
  } catch {
    return null;
  }
};
