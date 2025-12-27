// controllers/instituteController.js
const admin = require("firebase-admin");
const bcrypt = require("bcrypt");
const db = admin.firestore();

/**
 * Create institute -> admin only
 */
exports.createInstitute = async (req, res) => {
  try {
    const { name, branding, planType } = req.body;
    if (!name) return res.status(400).json({ error: "Missing institute name" });

    const docRef = await db.collection("institutes").add({
      name,
      branding: branding || {},
      planType: planType || "paid",
      createdAt: admin.firestore.FieldValue.serverTimestamp()
    });

    return res.json({ id: docRef.id });
  } catch (err) {
    console.error("createInstitute:", err);
    return res.status(500).json({ error: "Server error" });
  }
};

/**
 * Add paid student -> admin only
 * body: { name, email, password, instituteId }
 */
exports.addPaidStudent = async (req, res) => {
  try {
    const { name, email, password, instituteId } = req.body;
    if (!email || !password || !instituteId) return res.status(400).json({ error: "Missing fields" });

    const exists = await db.collection("users").where("email", "==", email).limit(1).get();
    if (!exists.empty) return res.status(400).json({ error: "User exists" });

    const hash = await bcrypt.hash(password, 10);
    const docRef = await db.collection("users").add({
      name: name || "",
      email,
      passwordHash: hash,
      role: "paidStudent",
      instituteId,
      isFreeUser: false,
      createdAt: admin.firestore.FieldValue.serverTimestamp()
    });

    return res.json({ id: docRef.id });
  } catch (err) {
    console.error("addPaidStudent:", err);
    return res.status(500).json({ error: "Server error" });
  }
};

/**
 * Add mentor -> admin only
 * body: { name, email, password, instituteId }
 */
exports.addMentor = async (req, res) => {
  try {
    const { name, email, password, instituteId } = req.body;
    if (!email || !password || !instituteId) return res.status(400).json({ error: "Missing fields" });

    const exists = await db.collection("users").where("email", "==", email).limit(1).get();
    if (!exists.empty) return res.status(400).json({ error: "User exists" });

    const hash = await bcrypt.hash(password, 10);
    const docRef = await db.collection("users").add({
      name: name || "",
      email,
      passwordHash: hash,
      role: "mentor",
      instituteId,
      isFreeUser: false,
      createdAt: admin.firestore.FieldValue.serverTimestamp()
    });

    return res.json({ id: docRef.id });
  } catch (err) {
    console.error("addMentor:", err);
    return res.status(500).json({ error: "Server error" });
  }
};
