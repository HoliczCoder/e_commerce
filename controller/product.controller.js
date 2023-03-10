const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

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

    // save ProductAttributeValueIndex
    // const attributes = await prisma.product.findMany({});
    const attributes = req.body.attributes;
    for (let i = 0; i < attributes.length; i += 1) {
      const attribute = attributes[i];
      if (attribute.value) {
        const attr = await prisma.atrribute.findUnique({
          where: {
            attribute_code: attribute.attribute_code,
          },
        });
        if (!attr) {
          return;
        }
        if (attr.type === "textarea" || attr.type === "text") {
          const flag = await prisma.productAttributeValueIndex.findUnique({
            where: {
              product_id: product.product_id,
            },
          });
          if (flag) {
            await prisma.productAttributeValueIndex.update({
              where: {
                product_id: product.product_id,
              },
              data: {
                option_text: attribute.value.trim(),
              },
            });
          } else {
            await prisma.productAttributeValueIndex.create({
              data: {
                product_id: product.product_id,
                attribute_id: attr.attribute_id,
                option_text: attribute.value.trim(),
              },
            });
          }
        } else if (attr.type === "multiselect") {
          await Promise.all(
            attribute.value.map(() => {
              (async () => {
                const option = await prisma.attributeOption.findUnique({
                  where: {
                    attribute_option_id: attribute.value,
                  },
                });
                if (!option) {
                  res.status(404).json({
                    res: "this attribute not exist",
                  });
                  return;
                }
                await prisma.productAttributeValueIndex.create({
                  data: {
                    product_id: product.product_id,
                    attribute_id: attr.attribute_id,
                    option_id: option.attribute_option_id,
                    option_text: option.option_text,
                  },
                });
              })();
            })
          );
          //
        } else if (attr.type === "select") {
          const option = await prisma.attributeOption.findUnique({
            where: {
              attribute_option_id: attribute.value,
            },
          });
          if (!option) {
            res.status(404).json({
              res: "this attribute not exist",
            });
            return;
            ///////////////////////////// so tired !!!!
          }
          // Delete old option if any
          await prisma.productAttributeValueIndex.delete({
            where: {
              attribute_id: attr.attribute_id,
            },
          });
          // Insert new option
          await prisma.productAttributeValueIndex.create({
            data: {
              product_id: product.product_id,
              attribute_id: attr.attribute_id,
              option_id: option.attribute_option_id,
              option_text: option.option_text,
            },
          });
        } else {
          await prisma.productAttributeValueIndex.create({
            data: {
              option_text: attribute.value,
            },
          });
        }
      }
    }

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
