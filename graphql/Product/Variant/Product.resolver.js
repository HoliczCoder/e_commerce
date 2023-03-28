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
          productCateogory.forEach((item) => {
            promises.push(
              prisma.category.findUnique({
                where: {
                  category_id: item.category_id,
                },
                // damn, thinking switching to raw query
              })
            );
          });
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
