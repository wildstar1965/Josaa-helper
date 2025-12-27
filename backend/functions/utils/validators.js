// utils/validators.js

function isEmail(s) {
  if (!s || typeof s !== "string") return false;
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(s);
}

function validateSignupBody(body) {
  const { email, password } = body;
  if (!email || !password) return { ok: false, error: "Missing fields" };
  if (!isEmail(email)) return { ok: false, error: "Invalid email" };
  if (typeof password !== "string" || password.length < 6) return { ok: false, error: "Password too short" };
  return { ok: true };
}

module.exports = { isEmail, validateSignupBody };
