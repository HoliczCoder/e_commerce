const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const resolver = {
  Query: {
    // pending
    // categories: async () => {

    // },
    category: async (_, { id }) => {
      // safe query
      return await prisma.$queryRaw`SELECT c.category_id, c.uuid, c.status,
        cd.name, c.include_in_nav, cd.description,
        cd.url_key, cd.meta_title, cd.meta_description, cd.meta_keywords
        FROM category as c INNER JOIN category_description as cd 
        ON c.category_id = cd.category_description_category_id
        WHERE c.category_id = ${id}`;
    },
    products: async (_, { filters = [] }) => {
      const query = `SELECT p.product_id, p.uuid,
        pd.name, p.status, p.sku, p.weight,
        p.tax_class, pd.description, pd.url_key,
        pd.meta_title, pd.meta_description, pd.meta_keywords,
        p.variant_group_id, p.visibility, p.group_id
        FROM product as p 
        LEFT JOIN product_description as pd 
        ON p.product_id = pd.product_description_product_id `;
      //
      const currentFilters = [];
      // Price filter
      const priceFilter = filters.find((f) => f.key === "price");
      //SQl injection risk free
      if (priceFilter) {
        const [min, max] = priceFilter.value
          .split("-")
          .map((v) => parseFloat(v));
        let currentPriceFilter;
        if (Number.isNaN(min) === false && Number.isNaN(max) === false) {
          //
          query.concat(`WHERE p.price BETWEEN ${min} AND ${max} `);
          //
          currentPriceFilter = {
            key: "price",
            operation: "=",
            value: `${min}-${max}`,
          };
          // ading to currentFilters
          if (currentPriceFilter) {
            currentFilters.push(currentPriceFilter);
          }
        }
      }
      // Qty filter
      const qtyFilter = filters.find((f) => f.key === "qty");
      if (qtyFilter) {
        const [min, max] = qtyFilter.value.split("-").map((v) => parseFloat(v));
        let currentQtyFilter;
        if (Number.isNaN(min) === false && Number.isNaN(max) === false) {
          //
          query.concat(`AND p.qty BETWEEN ${min} AND ${max} `);
          //
          currentQtyFilter = {
            key: "qty",
            operation: "=",
            value: `${min}-${max}`,
          };
          // adding to currentFilters
          if (currentPriceFilter) {
            currentFilters.push(currentPriceFilter);
          }
        }
      }
      // Name filter
      const nameFilter = filters.find((f) => f.key === "name");
      if (nameFilter) {
        //SQl injection risk
        query.concat(`AND pd.name LIKE %${nameFilter.value}% `);
        //
        currentFilters.push({
          key: "name",
          operation: "=",
          value: nameFilter.value,
        });
      }
      // Sku filter
      const skuFilter = filters.find((f) => f.key === "sku");
      if (skuFilter) {
        query.concat(`AND pd.name LIKE %${skuFilter.value}% `);
        //SQl injection risk
        currentFilters.push({
          key: "sku",
          operation: "=",
          value: skuFilter.value,
        });
      }
      // Total
      const total = await prisma.product.count();
      // Paging
      const page = filters.find((f) => f.key === "page") || { value: 1 };
      const limit = filters.find((f) => f.key === "limit") || { value: 20 };
      query.concat(`LIMIT ${limit} OFFSET ${page - 1} * ${limit}`);
      currentFilters.push({
        key: "page",
        operation: "=",
        value: page.value,
      });
      currentFilters.push({
        key: "limit",
        operation: "=",
        value: limit.value,
      });
      // finally query it
      const result = await prisma.$queryRaw`${query}`;
      //
      return {
        items: result,
        currentPage: page,
        total: total,
        currentFilters: currentFilters,
      };

      // Damn, I do want the library :((((
    },
  },
};

module.exports = resolver;
