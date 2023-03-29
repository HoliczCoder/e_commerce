const { ApolloServer } = require("@apollo/server");
const ProductResolver = require("./product/variant/Product.resolver");
const CategoryResolver = require("./Category/Category.resolver");
const { join } = require("node:path");
const { loadFilesSync } = require("@graphql-tools/load-files");
const { mergeTypeDefs } = require("@graphql-tools/merge");

const typeSources = [join(__dirname, "./**/*.graphql")];

const typeDefs = mergeTypeDefs(
  typeSources.map((source) => loadFilesSync(source))
);

const typeResolver = {};

Object.keys(ProductResolver).map((key) => {
  if (key !== "Query") {
    // adding
    typeResolver[key] = ProductResolver[key];
  }
});

Object.keys(CategoryResolver).map((key) => {
  if (key !== "Query") {
    // adding
    typeResolver[key] = CategoryResolver[key];
  }
});

console.log("typeResolver",typeResolver);

const P = ProductResolver.Query;
const C = CategoryResolver.Query;

const resolvers = {
  ...typeResolver,
  Query: {
    ...P,
    ...C,
  },
};

//
const server = new ApolloServer({
  typeDefs,
  resolvers,
});
module.exports = server;
