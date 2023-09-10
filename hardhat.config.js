require("@nomiclabs/hardhat-waffle");
require('dotenv').config({ path: './env/.env' });

// var from .env
const INFURA_PROJECT_ID = process.env.INFURA_PROJECT_ID;
const GOERLI_WALLET_PRIVATE_KEY = process.env.GOERLI_WALLET_PRIVATE_KEY;
const MUMBAI_WALLET_PRIVATE_KEY = process.env.MUMBAI_WALLET_PRIVATE_KEY;
const GOERLI_INFURA_URL = process.env.GOERLI_INFURA_URL
const MUMBAI_INFURA_URL = process.env.MUMBAI_INFURA_URL

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  defaultNetwork: "polygon_mumbai",
  networks: {
    hardhat: {
    },
    polygon_mumbai: {
      url: `${MUMBAI_INFURA_URL}/${INFURA_PROJECT_ID}`,
      accounts: [MUMBAI_WALLET_PRIVATE_KEY]
    }
  },
  solidity: {
    version: "0.4.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
};