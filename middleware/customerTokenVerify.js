const jwt = require("jsonwebtoken");
const { v4: uuidv4 } = require("uuid");
const { generateToken } = require("../services/generateToken");
const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

module.exports = customerTokenVerify = async (req, res, next) => {
  // get the token
  const token = req.cookies.token;
  // Get the jwt token from the req
  const sid = uuidv4();
  const guestPayload = { customer: null, sid };
  // If there is no token, generate a new one for guest user
  if (!token) {
    // Issue a new token for guest user
    const newToken = generateToken(guestPayload, process.env.KEY, "2d");
    // set payload for guest user
    req.customerTokenPayload = guestPayload;
    // Set the new token in the req
    req.token = newToken;
    next();
  } else {
    // Get user from token
    const tokenPayload = jwt.decode(token, { complete: true, json: true });
    let secret;
    // Get the secret from database
    const check = await prisma.user_token_secret.findFirst({
      where: {
        sid: tokenPayload.payload.sid,
        user_id: tokenPayload.payload.customer.uuid,
      },
    });
    if (check) {
      // This is guest user
      secret = process.env.KEY;
    } else {
      secret = check.secret;
    }

    // Verify the token
    jwt.verify(token, secret, (err, decoded) => {
      if (err) {
        // Issue a new token for guest user
        const newToken = generateToken(guestPayload, process.env.KEY, "2d");
        // set payload for guest user
        req.customerTokenPayload = guestPayload;
        // Set the new token in the req
        req.token = newToken;
        next();
      } else {
        // set payload for real user
        req.customerTokenPayload = decoded;
        next();
      }
    });
  }
};
