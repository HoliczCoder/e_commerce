const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const { saveAttribute, saveCategory } = require("../service/product.service");

const createProduct = async (req, res) => {
  try {
    const product = await prisma.product.create({
      data: {
        variant_group_id: req.body.variant_group_id,
        group_id: req.body.group_id,
        visibility: req.body.visibility,
        sku: req.body.sku,
        price: req.body.price,
        qty: req.body.qty,
        weight: req.body.weight,
        manage_stock: req.body.manage_stock,
        stock_availability: req.body.stock_availability,
        tax_class: req.body.tax_class,
        status: req.body.status,
      },
    });

    // save Attribute
    const attributes = req.body.attributes;
    if (attributes) {
      await saveAttribute(product, attributes);
      // @ts-ignore
      if (saveAttribute == false) {
        res.status(404).json({
          error: "save attribute failed",
        });
        return;
      }
    }

    // save Category
    const categories = req.body.categories;
    if (categories) {
      await saveCategory(product, categories);
      // @ts-ignore
      if (saveCategory == false) {
        res.status(404).json({
          error: "save category failed",
        });
        return;
      }
    }

    res.status(200).json({ res: product });
  } catch (error) {
    res.status(500).json({
      error: error,
    });
  }
};

const updateProduct = async (req, res) => {
  try {
    const product = await prisma.product.update({
      where: {
        product_id: req.body.product_id,
      },
      data: {
        variant_group_id: req.body.variant_group_id,
        group_id: req.body.group_id,
        visibility: req.body.visibility,
        sku: req.body.sku,
        price: req.body.price,
        qty: req.body.qty,
        weight: req.body.weight,
        manage_stock: req.body.manage_stock,
        stock_availability: req.body.stock_availability,
        tax_class: req.body.tax_class,
        status: req.body.status,
      },
    });

    // update Attribute
    const attributes = req.body.attributes;
    if (attributes) {
      await saveAttribute(product, attributes);
      // @ts-ignore
      if (saveAttribute == false) {
        res.status(404).json({
          error: "update attribute failed",
        });
        return;
      }
    }

    // update Category
    const categories = req.body.categories;
    if (categories) {
      await saveCategory(product, categories);
      // @ts-ignore
      if (saveCategory == false) {
        res.status(404).json({
          error: "update category failed",
        });
        return;
      }
    }

    res.status(200).json({ res: product });
  } catch (error) {
    res.status(500).json({
      error: error,
    });
  }
};

module.exports = {
  createProduct,
  updateProduct,
};
