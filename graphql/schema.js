import { ApolloServer } from "@apollo/server";
import ProductResolver from "./product/variant/Product.resolver";

const resolvers = {
  ...ProductResolver,
};

const typeDefs = `#graphql

  type Product {
  product_id: Int!
  uuid: String!
  name: String!
  status: Int!
  sku: String!
  weight: Weight!
  tax_class: Int
  description: String
  url_key: String
  meta_title: String
  meta_description: String
  meta_keywords: String
  variant_group_id: ID
  visibility: Int
  group_id: ID
  #   custom field
  categories: [Category]
  url: String
  editUrl: String
  updateApi: String!
  deleteApi: String!
}

type Query {
  product(id: ID): Product
}

type Category {
  # exist field
  category_id: ID!
  uuid: String!
  # join CategoryDescription table, is prisma allowed to join?
  name: String!
  status: Int!
  include_in_nav: Int!
  description: String
  url_key: String
  meta_title: String
  meta_description: String
  meta_keywords: String
  #   is this exist?
  #   image: CategoryImage
  products(filters: [FilterInput]): ProductCollection
  #   custom field
  url: String
  editUrl: String
  updateApi: String!
  deleteApi: String!
  availableAttributes: [FilterAttribute]
  priceRange: PriceRange
}

type ProductCollection {
  items: [Product]
  currentPage: Int!
  total: Int!
  currentFilters: [Filter]
}
`;

//
const server = new ApolloServer({
  typeDefs,
  resolvers,
});

module.exports = server
