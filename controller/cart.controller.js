const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const { modifyItem, removeItem, saveCart } = require("../service/cart.service");

const addMineCartItem = async (req, res) => {
  const { sku, qty, isAdding } = req.body;
  const cart_id = req.cart_id;

  try {
    // get product by sku
    const product = await prisma.product.findFirst({
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
    //
    const existCart = await prisma.cart.findFirst({
      where: {
        uuid: cart_id,
      },
    });
    //
    if (!existCart?.cart_id) {
      // get customer payload
      const customerTokenPayload = req.customerTokenPayload;
      // customer is real customer or guest customer is still creating their cart
      const customer = customerTokenPayload?.customer || {};
      const sid = customerTokenPayload.sid || null;
      // extract the customer info
      const {
        customer_id: customer_id,
        email: customer_email,
        group_id: customer_group_id,
        full_name: customer_full_name,
      } = customer;

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
      const item = await modifyItem(product, qty, newCart.cart_id, isAdding);
      // and save cart
      const savedCart = await saveCart(newCart, item, qty, isAdding);
      // get token for guest user dont have cart
      const token = req.token ?? req.token;
      // send token to guest user if token exist
      if (token) {
        res.cookie("token", token);
      }
      res.status(200).json({
        data: { item, savedCart },
      });
      return;
    } else {
      const item = await modifyItem(product, qty, existCart.cart_id, isAdding);
      // and save cart
      const savedCart = await saveCart(existCart, item, qty, isAdding);
      res.status(200).json({
        data: { item, savedCart },
      });
      return;
    }
    //
  } catch (error) {
    res.status(500).json({
      error: error,
    });
  }
};

const removeMineCartItem = async (req, res) => {
  const { sku } = req.body;
  const cart_id = req.cart_id;
  try {
    const existCart = await prisma.cart.findFirst({
      where: {
        uuid: cart_id,
      },
    });
    //
    if (!existCart) {
      res.status(404).json({
        error: "Cart not found",
      });
      return;
    } else {
      // get product by sku
      const product = await prisma.product.findFirst({
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
      // then remove item
      const removedItem = await removeItem(product, existCart.cart_id);
      // the save cart
      const savedCart = await saveCart(
        existCart,
        removedItem,
        removedItem?.qty,
        false
      );

      res.status(200).json({
        data: { removedItem, savedCart },
      });
    }
  } catch (error) {
    res.status(500).json({
      error: error,
    });
  }
  //
};

module.exports = {
  addMineCartItem,
  removeMineCartItem,
};
