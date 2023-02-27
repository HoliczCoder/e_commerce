const bcrypt = require("bcrypt");
const { compare } = require("bcrypt");
const { PrismaClient } = require("@prisma/client");
const { v4: uuidv4 } = require("uuid");
const prisma = new PrismaClient();
const { generateToken } = require("../services/generateToken");
  
const createCustomer = async (req, res) => {
  const { body } = req;
  const { email, full_name, password } = body;
  try {
    const hash = await bcrypt.hash(password, 10);
    await prisma.customer.create({
      data: {
        full_name: full_name,
        email: email,
        password: hash,
        group_id: 1,
        status: 1,
      },
    });
    res.json(prisma);
  } catch (error) {
    res.json({
      error: error,
    });
  }
};

const createCustomerSession = async (req, res) => {
  const { body } = req;
  const { email, password } = body;
  const customer = await prisma.customer.findFirst({
    where: {
      email: email,
    },
  });
  if (!customer) {
    res.status(400).json({
      error: {
        message: "Invalid email or password",
      },
    });
  } else {
    const { password: hash } = customer;
    const result = await compare(password, hash);
    if (!result) {
      res.status(400).json({
        error: {
          message: "Invalid email or password",
        },
      });
    } else {
      const sid = uuidv4();
      const guestPayload = { customer: null, sid };
      const newToken = generateToken(guestPayload, process.env.KEY, "2d");
    }
  }
};

module.exports = createCustomer;
