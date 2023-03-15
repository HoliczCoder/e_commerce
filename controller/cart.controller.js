const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const addMineCartItem = async (req, res) => {
  const isExistCart = prisma.cart.findUnique({
    where: {
      cart_id: req.body.cart_id,
    },
  });
  if (!isExistCart) {
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
    const { sku, qty } = req.body;
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
    // create a new cart
    cart = await prisma.cart.create({
      data: {
        customer_id,
        customer_full_name,
        customer_email,
        customer_group_id,
        sid,
      },
    });
    // If everything is fine, add the product to the cart
    const cartItem = await prisma.cartItem.create({
      data: {
        cart_id: cart.cart_id,
        product_id: product.product_id,
        product_sku: sku,
        product_name: product.ProductDescription.name,
        thumbnail: product.image,
        product_weigth: product.weight,
        product_price: product.price,
        product_price_incl_tax: product.price,
        final_price: product.price,
        final_price_incl_tax: product.price,
        // pending pending pending pending pending pending
        qty: qty,
      },
    });
  }
};

module.exports = {
  addMineCartItem,
};
