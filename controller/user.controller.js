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
    res.json({
      message: "register successfully",
    });
  } catch (error) {
    res.status(500).json({
      error: error,
    });
  }
};

const createCustomerSession = async (req, res) => {
  const { body } = req;
  const { email, password } = body;
  const customer = await prisma.customer.findUnique({
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
    const result = await compare(password.toString(), hash.toString());
    if (!result) {
      res.status(400).json({
        error: {
          message: "Invalid email or password",
        },
      });
    } else {
      const sid = uuidv4();
      const JWT_SECRET = uuidv4();
      // find user_token_secret
      const userTokenSecret = await prisma.userTokenSecret.findFirst({
        where: {
          user_id: customer.uuid,
        },
      });
      // if userTokenSecret exist?
      if (userTokenSecret) {
        await prisma.userTokenSecret.update({
          where: {
            user_id: customer.uuid,
          },
          data: {
            sid: sid,
            secret: JWT_SECRET,
          },
        });
      } else {
        await prisma.userTokenSecret.create({
          data: {
            user_id: customer.uuid,
            sid: sid,
            secret: JWT_SECRET,
          },
        });
      }
      // delete customer password
      delete customer.password;
      // create newPayload
      if (!customer.password) {
        const newPayload = { customer: customer, sid };
        // create new token
        // const token = sign(newPayload, JWT_SECRET);
        const token = generateToken(newPayload, JWT_SECRET, "2d");
        // send token to cookie
        res.cookie("token", token);
        res.status(200).json({
          message: "login successfully",
        });
      }
    }
  }
};

const deleteCustomerSession = async (req, res) => {
  const customerTokenPayload = req.customerTokenPayload;
  const user_id = customerTokenPayload?.customer?.uuid;
  if (user_id) {
    await prisma.userTokenSecret.deleteMany({
      where: {
        user_id: user_id,
      },
    });
    res.status(200).json({
      message: "logout successfully",
    });
  } else {
    res.status(200).json({
      message: "you have already logged out",
    });
  }
};

module.exports = {
  createCustomer,
  createCustomerSession,
  deleteCustomerSession,
};
