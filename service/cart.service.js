const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

//product_id: product.product_id, qty
const addItem = async (product, qty, cart) => {
  console.log(cart);
  console.log(product);
  // check if item exist in cart
  const ifExistCartItem = await prisma.cartItem.findUnique({
    where: {
      cart_id_product_id: {
        cart_id: cart.cart_id,
        product_id: product.product_id,
      },
    },
  });
  let cartItem = "";
  if (!ifExistCartItem) {
    // create cartItem
    cartItem = await prisma.cartItem.create({
      data: {
        cart_id: cart.cart_id,
        product_id: product.product_id,
        product_sku: product.sku,
        product_name: product.ProductDescription.name,
        thumbnail: product.image,
        product_weigth: product.weight,
        product_price: product.price,
        product_price_incl_tax: product.price,
        qty: qty,
        final_price: product.price,
        final_price_incl_tax: product.price,
        total: product.price * qty,
      },
    });
  } else {
    // update cartItem
    cartItem = await prisma.cartItem.update({
      where: {
        cart_id_product_id: {
          cart_id: cart.cart_id,
          product_id: product.product_id,
        },
      },
      data: {
        qty: ifExistCartItem.qty + qty, // adding quantity
        final_price: product.price,
        final_price_incl_tax: product.price,
        total: product.price * (ifExistCartItem.qty + qty),
      },
    });
  }
  //
  return cartItem;
};

module.exports = {
  addItem,
};
