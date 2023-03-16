const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const { addItem } = require("../service/cart.service");

const addMineCartItem = async (req, res) => {
  const { sku, qty } = req.body;
  const item = "";
  const existCart = prisma.cart.findUnique({
    where: {
      cart_id: req.body.cart_id,
    },
  });
  if (!existCart) {
    // create a new cart
    const customerTokenPayload = req.customerTokenPayload;
    // customer is real customer or guest customer is still creating their cart
    const customer = customerTokenPayload?.customer || {};
    const sid = customerTokenPayload.sid || null;
    // extract the customer info
    const {
      customerId: customer_id,
      email: customer_email,
      groupId: customer_group_id,
      fullName: customer_full_name,
    } = customer;
    // get product by sku
    const product = prisma.product.findUnique({
      where: {
        sku: sku,
        status: 1,
      },
      include: {
        ProductDescription: true,
      },
    });
    //
    if (!product) {
      res.status(404).json({
        error: "Product not found",
      });
      return;
    }
    // create a new cart (which have no product)
    const newCart = await prisma.cart.create({
      data: {
        customer_id: customer_id,
        customer_full_name: customer_full_name,
        customer_email: customer_email,
        customer_group_id: customer_group_id,
        sid: sid,
        status: 1,
      },
    });
    // If everything is fine, add the product to the cart
    item = await addItem(product, qty, newCart);
  } else {
    // get product by sku
    const product = prisma.product.findUnique({
      where: {
        sku: sku,
        status: 1,
      },
      include: {
        ProductDescription: true,
      },
    });
    //
    item = await addItem(product, qty, existCart);
  }
  //
  res.status(200).json({
    data: { item },
  });
  return;
};

module.exports = {
  addMineCartItem,
};
