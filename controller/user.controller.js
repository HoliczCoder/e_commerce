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
      const JWT_SECRET = uuidv4();
      // update customer new secret
      // update customer new sid
      const customer = await prisma.customer.update({
        where: {
          email: email,
        },
        data: {
          user_id: customer.uuid,
          sid: sid,
          secret: JWT_SECRET,
        },
      });
      // delete customer password
      delete customer.password;
      // create newPayload
      if (!customer.password) {
        const newPayload = { customer: customer, sid };
        // creare new token
        // const token = sign(newPayload, JWT_SECRET);
        const token = generateToken(newPayload, JWT_SECRET, "2d");
        res.status(200).json({
          token: token,
        });
      }
    }
  }
};

module.exports = { createCustomer, createCustomerSession };
