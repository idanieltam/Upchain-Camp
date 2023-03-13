require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require('hardhat-abi-exporter');
require("dotenv").config();

module.exports = {
  solidity: "0.8.4",
  networks: {
    goerli: {
      url: process.env.GOERLI_URL,
      accounts: [process.env.PRIVATE_KEY]
    },
  },
  etherscan: {
    apiKey: {
      goerli: process.env.ETHSCAN_API
    }
  },
  abiExporter: {
    path:'./deployments/abi',
    clear: true,
    flat: true,
    only: [],
    spacing: 2,
    pretty: true
  }
};