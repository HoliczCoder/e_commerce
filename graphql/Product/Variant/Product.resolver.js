const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const resolvers = {
  Product: {
    // categories: async (product) => {
    //   try {
    //     const productAttributeValueIndex =
    //       await prisma.productAttributeValueIndex.findMany({
    //         where: {
    //           product_id: product.product_id,
    //         },
    //       });
    //     // if exist
    //     if (productAttributeValueIndex.length) {
    //       const attributes = [];
    //       const promises = [];
    //       // find all attribute with attribute_id
    //       productAttributeValueIndex.forEach((item) => {
    //         promises.push(
    //           prisma.atrribute.findUnique({
    //             where: {
    //               attribute_id: item.attribute_id,
    //             },
    //           })
    //         );
    //       });
    //       //
    //       await Promise.allSettled(promises).then((results) =>
    //         results.forEach((result) => {
    //           console.log(result.status);
    //           attributes.push(result);
    //         })
    //       );
    //       //
    //       return attributes;
    //     } else {
    //       return null;
    //     }
    //   } catch (error) {
    //     console.log(error);
    //   }
    // },
    categories: async (product) => {
      try {
        const productCateogory = await prisma.productCateogory.findMany({
          where: {
            product_id: product.product_id,
          },
        });
        if (productCateogory.length) {
          const categories = [];
          const promises = [];
          // find all categories
          productCateogory.forEach((item) => {
            promises.push(
              prisma.$queryRaw`SELECT c.category_id, c.uuid, c.status,
              cd.name, c.include_in_nav, cd.description,
              cd.url_key, cd.meta_title, cd.meta_description, cd.meta_keywords
              FROM category as c INNER JOIN category_description as cd 
              ON c.category_id = cd.category_description_id
              WHERE c.category_id = ${item.category_id}`
            );
          });
          // settle all
          await Promise.allSettled(promises).then((results) =>
            results.forEach((result) => {
              console.log(result);
              categories.push(result);
            })
          );
          //
          return categories;
        } else {
          return null;
        }
      } catch (error) {
        console.log(error);
      }
    },
  },
  Query: {
    product: async (_, { product_id }) => {
      try {
        return await prisma.product.findUnique({
          where: {
            product_id: product_id,
          },
          include: {
            ProductDescription,
          },
        });
      } catch (error) {
        // not a legit way to deal with error
        console.log(error);
      }
    },
  },
};

module.exports = resolvers;
