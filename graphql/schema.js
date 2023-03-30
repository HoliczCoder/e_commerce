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

const loopResolver = [ProductResolver, CategoryResolver];
const typeResolver = {};

loopResolver.forEach((itemResolver) => {
  Object.keys(itemResolver).map((key) => {
    if (key !== "Query") {
      // adding
      typeResolver[key] = itemResolver[key];
    }
  });
});

const resolvers = {
  ...typeResolver,
  Query: {
    ...(ProductResolver.Query),
    ...(CategoryResolver.Query),
  },
};

console.log(resolvers);

//
const server = new ApolloServer({
  typeDefs,
  resolvers,
});
module.exports = server;
