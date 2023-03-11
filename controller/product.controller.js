const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const { saveAttribute } = require("../service/product.service");

const createProduct = async (req, res) => {
  try {
    const product = await prisma.product.create({
      data: {
        ...(req.body.variant_group_id && {
          variant_group_id: req.body.variant_group_id,
        }),
        ...(req.body.group_id && {
          group_id: req.body.group_id,
        }),
        visibility: req.body.visibility,
        sku: req.body.sku,
        price: req.body.price,
        qty: req.body.qty,
        weight: req.body.weight,
        manage_stock: req.body.manage_stock,
        stock_availability: req.body.stock_availability,
        ...(req.body.tax_class && { tax_class: req.body.tax_class }),
        status: req.body.status,
      },
    });

    const attributes = req.body.attributes;

    // save Attribute
    await saveAttribute(product, attributes);
    // @ts-ignore
    if (saveAttribute == false) {
      res.status(404).json({
        error: "save attribute failed",
      });
    }

    // save Category
    // Pending

    res.status(200).res({ res: product });
  } catch (error) {
    res.status(500).json({
      error: error,
    });
  }
};

module.exports = {
  createProduct,
};
