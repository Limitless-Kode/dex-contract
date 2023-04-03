const ClaverToken = artifacts.require("ClaverToken");
const EthSwap = artifacts.require("EthSwap");

module.exports = async function (deployer) {
  await deployer.deploy(ClaverToken);
  const token = await ClaverToken.deployed();

  await deployer.deploy(EthSwap, token.address);
  const ethSwap = await EthSwap.deployed();
  await token.transfer(ethSwap.address, "1000000000000000000000000");
};
