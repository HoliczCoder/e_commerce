const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

//product_id: product.product_id, qty
const modifyItem = async (product, qty, cart_id, isAdding) => {
  // check if item exist in cart
  const ifExistCartItem = await prisma.cartItem.findUnique({
    where: {
      cart_id_product_id: {
        cart_id: cart_id,
        product_id: product.product_id,
      },
    },
  });
  if (!ifExistCartItem) {
    // create cartItem
    const cartItem = await prisma.cartItem.create({
      data: {
        cart_id: cart_id,
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
    return cartItem;
  } else {
    // update cartItem
    const cartItem = await prisma.cartItem.update({
      where: {
        cart_id_product_id: {
          cart_id: cart_id,
          product_id: product.product_id,
        },
      },
      data: {
        qty: ifExistCartItem.qty + qty, // modify quantity
        ...(isAdding == true
          ? { qty: ifExistCartItem.qty + qty }
          : { qty: ifExistCartItem.qty - qty }),
        final_price: product.price,
        final_price_incl_tax: product.price,
        ...(isAdding == true
          ? { total: product.price * (ifExistCartItem.qty + qty) }
          : { total: product.price * (ifExistCartItem.qty - qty) }),
      },
    });
    return cartItem;
  }
};

const saveCart = async (cart, item, qty, isAdding) => {
  return await prisma.cart.update({
    where: {
      cart_id: cart.cart_id,
    },
    data: {
      ...(isAdding == true
        ? {
            total_qty: cart.total_qty + qty,
            sub_total: cart.sub_total + item.final_price_incl_tax * qty,
            grand_total: cart.grand_total + item.final_price_incl_tax * qty,
          }
        : {
            total_qty: cart.total_qty - qty,
            sub_total: cart.sub_total - item.final_price_incl_tax * qty,
            grand_total: cart.grand_total - item.final_price_incl_tax * qty,
          }),
    },
  });
};

const removeItem = async (product, cart_id) => {
  // find if cart item exist
  const ifExistCartItem = await prisma.cartItem.findUnique({
    where: {
      cart_id_product_id: {
        cart_id: cart_id,
        product_id: product.product_id,
      },
    },
  });
  if (ifExistCartItem) {
    const cartItem = await prisma.cartItem.delete({
      where: {
        cart_id_product_id: {
          cart_id: cart_id,
          product_id: product.product_id,
        },
      },
    });
    return cartItem;
  }
};

module.exports = {
  modifyItem,
  removeItem,
  saveCart,
};
