require("@nomiclabs/hardhat-waffle");

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.4.17",
  networks: {
    goerli: {
      // url: 'https://eth-rinkeby.alchemyapi.io/v2/EYABeRjKV3KIPeqTz-FqNtJdTm2XRHCR',
      url: 'https://goerli.infura.io/v3/a07f9e63ceb740dda9a9aef0df0fd64d',
      accounts: [
        'b8f06d9458c3d173fb25939ad8dbfd0e218ee2547f19fa05cf29d2519c361af2'
      ]
    },
  }
};