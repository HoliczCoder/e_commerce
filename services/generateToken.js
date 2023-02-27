const jwt = require("jsonwebtoken");

module.exports.generateToken = (payload, secret, expiresDate) => {
  const token = jwt.sign(payload, secret, { expiresIn: expiresDate });
  return token;
};
