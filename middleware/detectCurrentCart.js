const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

module.exports = detectCurrentCart = async (req, res, next) => {
  const customerTokenPayload = req.customerTokenPayload;
  const { sid } = customerTokenPayload;
  // Check if any cart is associated with the session id
  const cart = await prisma.cart.findUnique({
    where: {
      sid: sid,
    },
  });
  if (cart) {
    // send cart_id for using
    req.cart_id = cart.uuid;
  } else {
    const customerId = customerTokenPayload.customer?.customer_id || null;
    if (customerId) {
      // Check if any cart belong to real user that have a old session id
      const customerCart = await prisma.cart.findUnique({
        where: {
          customer_id: customerId,
        },
      });
      if (customerCart) {
        // Update the cart with the session id
        await prisma.cart.update({
          where: {
            uuid: customerCart.uuid,
          },
          data: {
            sid: sid,
          },
        });
        // send cart_id for using
        req.cart_id = customerCart.uuid;
      }
      // send cart_id for using
      req.cart_id = null;
    } else {
      // there is no current cart for real user
      req.cart_id = null;
    }
  }
};
