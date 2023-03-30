const { PrismaClient, Prisma } = require("@prisma/client");
const prisma = new PrismaClient({
  log: ["query"],
});

const resolver = {
  Query: {
    // pending
    // categories: async () => {

    // },
    category: async (_, { id }) => {
      // safe query
      const result =
        await prisma.$queryRaw`SELECT c.category_id, c.uuid, c.status,
        cd.name, c.include_in_nav, cd.description,
        cd.url_key, cd.meta_title, cd.meta_description, cd.meta_keywords
        FROM category as c INNER JOIN category_description as cd 
        ON c.category_id = cd.category_description_category_id
        WHERE c.category_id = ${id} LIMIT 1`;
      return result[0];
    },
    products: async (_, { filters = [] }) => {
      const currentFilters = [];
      let queryPrice;
      let queryQty;
      let queryName;
      let querySku;

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
          queryPrice = Prisma.sql` WHERE p.price BETWEEN ${min} AND ${max} `;
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
          queryQty = Prisma.sql` AND p.qty BETWEEN ${min} AND ${max} `;
          //
          currentQtyFilter = {
            key: "qty",
            operation: "=",
            value: `${min}-${max}`,
          };
          // adding to currentFilters
          if (currentQtyFilter) {
            currentFilters.push(currentQtyFilter);
          }
        }
      }
      // Name filter
      const nameFilter = filters.find((f) => f.key === "name");
      if (nameFilter) {
        const stringValue = `%${nameFilter.value}%`
        queryName = Prisma.sql` AND pd.name LIKE ${stringValue} `;
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
        const stringValue = `%${skuFilter.value}%`
        querySku = Prisma.sql` AND p.sku LIKE ${stringValue} `;
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
      //
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

      const result =
        await prisma.$queryRaw`SELECT p.product_id, p.uuid, pd.name, p.status,
      p.sku, p.weight, p.tax_class, pd.description, 
      pd.url_key, pd.meta_title, pd.meta_description, 
      pd.meta_keywords, p.variant_group_id, p.visibility, p.group_id 
      FROM product as p  LEFT JOIN product_description as pd 
      ON p.product_id = pd.product_description_product_id 
      ${queryPrice ? queryPrice : Prisma.empty}
      ${queryQty ? queryQty : Prisma.empty}
      ${queryName ? queryName : Prisma.empty}
      ${querySku ? querySku : Prisma.empty}
      LIMIT ${limit.value} OFFSET ${(page.value - 1) * limit.value}
      `;
      //
      return {
        items: result,
        currentPage: page.value,
        total: total,
        currentFilters: currentFilters,
      };

      // Damn, I do want the library :((((
    },
  },
};

module.exports = resolver;
