const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const saveAttribute = async (product, attributes) => {
  for (let i = 0; i < attributes.length; i += 1) {
    const attribute = attributes[i];
    if (attribute.value) {
      const attr = await prisma.atrribute.findUnique({
        where: {
          attribute_code: attribute.attribute_code,
        },
      });
      if (!attr) {
        return false;
      }
      if (attr.type === "textarea" || attr.type === "text") {
        const flag = await prisma.productAttributeValueIndex.findUnique({
          where: {
            // find with unique product_id and attribute_id
            product_id_attribute_id: {
              product_id: product.product_id,
              attribute_id: attr.attribute_id,
            },
          },
        });
        if (flag) {
          return await prisma.productAttributeValueIndex.update({
            where: {
              product_id_attribute_id: {
                product_id: product.product_id,
                attribute_id: attr.attribute_id,
              },
            },
            data: {
              option_text: attribute.value.trim(),
            },
          });
        } else {
          return await prisma.productAttributeValueIndex.create({
            data: {
              product_id: product.product_id,
              attribute_id: attr.attribute_id,
              option_text: attribute.value.trim(),
            },
          });
        }
      } else if (attr.type === "multiselect") {
        return await Promise.all(
          attribute.value.map(() => {
            (async () => {
              const option = await prisma.attributeOption.findUnique({
                where: {
                  attribute_option_id: attribute.value,
                },
              });
              if (!option) {
                return false;
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
          return false;
        }
        // Delete old option if any
        await prisma.productAttributeValueIndex.delete({
          where: {
            product_id_attribute_id: {
              product_id: product.product_id,
              attribute_id: attr.attribute_id,
            },
          },
        });
        // Insert new option
        return await prisma.productAttributeValueIndex.create({
          data: {
            product_id: product.product_id,
            attribute_id: attr.attribute_id,
            option_id: option.attribute_option_id,
            option_text: option.option_text,
          },
        });
      } else {
        return false;
      }
    }
  }
};

module.exports = { saveAttribute };
