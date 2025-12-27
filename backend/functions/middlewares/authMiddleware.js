// middlewares/authMiddleware.js
const jwt = require("../utils/jwt");

exports.verifyAccessToken = (req, res, next) => {
  const auth = req.headers.authorization || "";
  const m = auth.match(/^Bearer (.+)$/);
  if (!m) return res.status(401).json({ error: "Missing Authorization header" });

  const token = m[1];
  try {
    const decoded = jwt.verifyAccess(token);
    req.user = decoded; // { uid, role, instituteId }
    return next();
  } catch (err) {
    return res.status(401).json({ error: "Invalid or expired access token" });
  }
};
