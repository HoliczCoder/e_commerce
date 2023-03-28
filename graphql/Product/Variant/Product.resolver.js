const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const resolvers = {
  Product: {
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
              ON c.category_id = cd.category_description_category_id
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
    product: async (_, { id }) => {
      try {
        const result = await prisma.$queryRaw`SELECT p.product_id, p.uuid,
        pd.name, p.status, p.sku, p.weight,
        p.tax_class, pd.description, pd.url_key,
        pd.meta_title, pd.meta_description, pd.meta_keywords,
        p.variant_group_id, p.visibility, p.group_id
        FROM product as p 
        LEFT JOIN product_description as pd 
        ON p.product_id = pd.product_description_product_id
        WHERE p.product_id = ${id} LIMIT 1`;
        //
        return result[0];
      } catch (error) {
        // not a legit way to deal with error
        console.log(error);
      }
    },
  },
};

module.exports = resolvers;
