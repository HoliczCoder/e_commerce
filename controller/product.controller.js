const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const createProduct = (req, res) => {
  const product = prisma.product.create({
    data: {
      ...(variant_group_id && { variant_group_id: req.body.variant_group_id }),
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
};
