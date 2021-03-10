const path = require("path");

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  contracts_build_directory: path.join(__dirname, "client/src/contracts"),
  networks: {
    develop: {
      // Localhost (default: none)
      port: 8545, // Standard Ethereum port (default: none)
      // Any network (default: none)
    },
    // Useful for deploying to a public network.
    // NB: It's important to wrap the provider as a function.
  },

  compilers: {
    solc: {
      version: "0.8.1",
    },
  },
};
