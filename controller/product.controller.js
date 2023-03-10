const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const createProduct = (req, res) => {
  try {
    const product = prisma.product.create({
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
