// index.js
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const express = require("express");
const cors = require("cors");

admin.initializeApp();
const app = express();
app.use(cors({ origin: true }));
app.use(express.json());

// Middlewares
const { verifyAccessToken } = require("./middlewares/authMiddleware");
const { requireRole } = require("./middlewares/rbacMiddleware");
const { audit } = require("./middlewares/auditMiddleware");

// Controllers
const authController = require("./controllers/authController");
const instituteController = require("./controllers/instituteController");

// AUTH ROUTES
app.post("/auth/signup/free", audit("signup_free"), authController.signupFree);
app.post("/auth/login", audit("login"), authController.login);
app.post("/auth/refresh", authController.refreshToken);
app.post("/auth/logout", audit("logout"), authController.logout);
app.get("/auth/me", verifyAccessToken, authController.me);

// ADMIN ROUTES
app.post(
  "/institute/create",
  verifyAccessToken,
  requireRole("admin"),
  audit("institute_create"),
  instituteController.createInstitute
);

app.post(
  "/institute/add-student",
  verifyAccessToken,
  requireRole("admin"),
  audit("add_student"),
  instituteController.addPaidStudent
);

app.post(
  "/institute/add-mentor",
  verifyAccessToken,
  requireRole("admin"),
  audit("add_mentor"),
  instituteController.addMentor
);

// Health Check
app.get("/ping", (req, res) => res.json({ ok: true }));

exports.api = functions.region("asia-south1").https.onRequest(app);

