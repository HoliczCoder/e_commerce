const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const saveAttribute = async (product, attributes) => {
  for (let i = 0; i < attributes.length; i += 1) {
    const attribute = attributes[i];
    if (attribute.value) {
      // find atrribute
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
        // this shit is not good
        return;
        return await Promise.all(
          // why attribute have so much value? have to check create attribute again
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
        // If exist
        const isExistProductAttributeValueIndex =
          await prisma.productAttributeValueIndex.findUnique({
            where: {
              product_id_attribute_id: {
                product_id: product.product_id,
                attribute_id: attr.attribute_id,
              },
            },
          });
        // Delete old option if any //
        if (isExistProductAttributeValueIndex) {
          await prisma.productAttributeValueIndex.delete({
            where: {
              product_id_attribute_id: {
                product_id: product.product_id,
                attribute_id: attr.attribute_id,
              },
            },
          });
        }
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

const saveCategory = async (product, categories) => {
  const promises = [];
  for (let i = 0; i < categories.length; i += 1) {
    const category = await prisma.category.findUnique({
      where: {
        category_id: categories[i],
      },
    });
    if (category) {
      promises.push(
        prisma.productCateogory.create({
          data: {
            category_id: categories[i],
            product_id: product.product_id,
          },
        })
      );
    } else {
      return false;
    }
  }
  //
  return await Promise.allSettled(promises);
};

const updateCategory = async (product, categories) => {
  // If exist productCateogory
  const ifExistProductCateogory = await prisma.productCateogory.findMany({
    where: {
      product_id: product.product_id,
    },
  });
  // Delete all categories
  if (ifExistProductCateogory) {
    await prisma.productCateogory.deleteMany({
      where: {
        product_id: product.product_id,
      },
    });
  }

  let promises = [];

  // Insert new categories
  for (let i = 0; i < categories.length; i += 1) {
    const category = await prisma.category.findUnique({
      where: {
        category_id: categories[i],
      },
    });
    if (category) {
      promises.push(
        prisma.productCateogory.create({
          data: {
            category_id: categories[i],
            product_id: product.product_id,
          },
        })
      );
    } else {
      return false;
    }
  }
  //
  return await Promise.allSettled(promises);
};

const saveDescription = async (product, productDescription) => {
  try {
    return await prisma.productDescription.create({
      data: {
        product_description_product_id: product.product_id,
        name: productDescription.name,
        description: productDescription.description,
        short_description: productDescription.short_description,
        url_key: productDescription.url_key,
        meta_title: productDescription.meta_title,
        meta_description: productDescription.meta_description,
        meta_keywords: productDescription.meta_keywords,
      },
    });
  } catch (error) {
    console.log(error);
    return false;
  }
};

const updateDescription = async (product, productDescription) => {
  try {
    // if exist
    const ifExistProductDescription =
      await prisma.productDescription.findUnique({
        where: {
          product_description_product_id: product.product_id,
        },
      });
    // delete first
    if (ifExistProductDescription) {
      await prisma.productDescription.delete({
        where: {
          product_description_product_id: product.product_id,
        },
      });
    }
    // then recreate
    return await prisma.productDescription.create({
      data: {
        product_description_product_id: product.product_id,
        name: productDescription.name,
        description: productDescription.description,
        short_description: productDescription.short_description,
        url_key: productDescription.url_key,
        meta_title: productDescription.meta_title,
        meta_description: productDescription.meta_description,
        meta_keywords: productDescription.meta_keywords,
      },
    });
  } catch (error) {
    console.log(error);
    return false;
  }
};

module.exports = {
  saveAttribute,
  saveCategory,
  updateCategory,
  saveDescription,
  updateDescription,
};
