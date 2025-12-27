const admin = require("firebase-admin");
const bcrypt = require("bcrypt");
const db = admin.firestore();
const { signAccess, signRefresh, verifyRefresh } = require("../utils/jwt");

exports.signupFree = async (req, res) => {
  try {
    const { name, email, password } = req.body;

    if (!email || !password)
      return res.status(400).json({ error: "Missing email/password" });

    const already = await db.collection("users").where("email", "==", email).get();
    if (!already.empty)
      return res.status(400).json({ error: "User already exists" });

    const hash = await bcrypt.hash(password, 10);

    const userRef = await db.collection("users").add({
      name,
      email,
      passwordHash: hash,
      role: "freeStudent",
      instituteId: null,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return res.json({ uid: userRef.id, ok: true });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: "Server error" });
  }
};

exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;

    const snap = await db.collection("users").where("email", "==", email).get();
    if (snap.empty) return res.status(401).json({ error: "Invalid credentials" });

    const doc = snap.docs[0];
    const user = doc.data();

    const ok = await bcrypt.compare(password, user.passwordHash);
    if (!ok) return res.status(401).json({ error: "Invalid credentials" });

    const payload = { uid: doc.id, role: user.role };
    const accessToken = signAccess(payload);
    const refreshToken = signRefresh({ uid: doc.id });

    await db.collection("tokens").add({
      uid: doc.id,
      token: refreshToken,
      revoked: false,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return res.json({
      accessToken,
      refreshToken,
      user: {
        uid: doc.id,
        name: user.name,
        email: user.email,
        role: user.role,
      },
    });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: "Server error" });
  }
};

exports.refreshToken = async (req, res) => {
  try {
    const { refreshToken } = req.body;
    const decoded = verifyRefresh(refreshToken);

    if (!decoded) return res.status(401).json({ error: "Invalid token" });

    const uid = decoded.uid;

    const check = await db.collection("tokens").where("token", "==", refreshToken).get();
    if (check.empty) return res.status(401).json({ error: "Unknown token" });

    const tokenDoc = check.docs[0];

    if (tokenDoc.data().revoked)
      return res.status(401).json({ error: "Revoked token" });

    await tokenDoc.ref.update({ revoked: true });

    const user = (await db.collection("users").doc(uid).get()).data();

    const newAccess = signAccess({ uid, role: user.role });
    const newRefresh = signRefresh({ uid });

    await db.collection("tokens").add({
      uid,
      token: newRefresh,
      revoked: false,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return res.json({ accessToken: newAccess, refreshToken: newRefresh });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
};

exports.logout = async (req, res) => {
  const { refreshToken } = req.body;

  const snap = await db.collection("tokens").where("token", "==", refreshToken).get();
  if (!snap.empty)
    await snap.docs[0].ref.update({ revoked: true });

  res.json({ ok: true });
};

exports.me = async (req, res) => {
  const user = await db.collection("users").doc(req.user.uid).get();
  res.json({ uid: req.user.uid, ...user.data() });
};
