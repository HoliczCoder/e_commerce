const { PrismaClient, Prisma } = require("@prisma/client");
const prisma = new PrismaClient({
  log: ["query"],
});

const resolver = {
  Query: {
    // pending
    categories: async (_, { filters = [] }) => {
      const currentFilters = [];
      let queryIncludeInNav;
      let queryName;
      let queryStatus;
      let queryOrder;

      // Name filter
      const nameFilter = filters.find((f) => f.key === "name");
      //
      if (nameFilter) {
        const stringValue = `%${nameFilter.value}%`;
        //
        queryName = Prisma.sql` WHERE cd.name LIKE ${stringValue} `;
        //
        currentFilters.push({
          key: "name",
          operation: "=",
          value: nameFilter.value,
        });
      }
      // Status filter
      const statusFilter = filters.find((f) => f.key === "status");
      if (statusFilter) {
        if (nameFilter) {
          queryStatus = Prisma.sql` AND c.status = ${nameFilter.value} `;
        } else {
          queryStatus = Prisma.sql` WHERE c.status = ${nameFilter.value} `;
        }
        //
        currentFilters.push({
          key: "status",
          operation: "=",
          value: statusFilter.value,
        });
      }
      // includeInNav filter
      const includeInNav = filters.find((f) => f.key === "includeInNav");
      if (includeInNav) {
        if (nameFilter || statusFilter) {
          queryIncludeInNav = Prisma.sql` AND c.include_in_nav = ${includeInNav.value} `;
        } else {
          queryIncludeInNav = Prisma.sql` WHERE c.include_in_nav = ${includeInNav.value} `;
        }
        //
        currentFilters.push({
          key: "includeInNav",
          operation: "=",
          value: includeInNav.value,
        });
      }
      // order filter
      const sortBy = filters.find((f) => f.key === "sortBy");
      const sortOrder = filters.find(
        (f) => f.key === "sortOrder" && ["ASC", "DESC"].includes(f.value)
      ) || { value: "ASC" };
      if (sortBy && sortOrder) {
        queryOrder = Prisma.sql` ORDER BY ${sortBy.value} ${sortOrder.value}`;
        //
        currentFilters.push({
          key: "sortOrder",
          operation: "=",
          value: sortOrder.value,
        });
      }
      // Total
      const total = await prisma.category.count();
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
      // Finally query it
      const result =
        await prisma.$queryRaw`SELECT c.category_id, c.uuid, c.status,
      cd.name, c.include_in_nav, cd.description,
      cd.url_key, cd.meta_title, cd.meta_description, cd.meta_keywords
      FROM category as c INNER JOIN category_description as cd 
      ON c.category_id = cd.category_description_category_id
      ${queryName ? queryName : Prisma.empty}
      ${queryStatus ? queryStatus : Prisma.empty}
      ${queryIncludeInNav ? queryIncludeInNav : Prisma.empty}
      ${queryOrder ? queryOrder : Prisma.empty}
      LIMIT ${limit.value} OFFSET ${(page.value - 1) * limit.value}
      `;
      //
      return {
        items: result,
        currentPage: page.value,
        total: total,
        currentFilters: currentFilters,
      };
    },
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
      //
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
          if (priceFilter) {
            queryQty = Prisma.sql` AND p.qty BETWEEN ${min} AND ${max} `;
          } else {
            queryQty = Prisma.sql` WHERE p.qty BETWEEN ${min} AND ${max} `;
          }
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
        const stringValue = `%${nameFilter.value}%`;
        //
        if (priceFilter || qtyFilter) {
          queryName = Prisma.sql` AND pd.name LIKE ${stringValue} `;
        } else {
          queryName = Prisma.sql` WHERE pd.name LIKE ${stringValue} `;
        }
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
        const stringValue = `%${skuFilter.value}%`;
        //
        if (priceFilter || qtyFilter || nameFilter) {
          querySku = Prisma.sql` AND p.sku LIKE ${stringValue} `;
        } else {
          querySku = Prisma.sql` WHERE p.sku LIKE ${stringValue} `;
        }

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
    },
  },
  Category: {
    products: async (category, { filters = [] }) => {
      // pending, damn, so much thing to write
    },
  },
};

module.exports = resolver;
