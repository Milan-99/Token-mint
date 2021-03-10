var tfuel = artifacts.require("./tfuel.sol");
var thetha = artifacts.require("./thetha.sol");

module.exports = async function (deployer) {
  await deployer.deploy(tfuel, "XBET", "XBET", 0, 0);
  const xbet = await tfuel.deployed();

  await deployer.deploy(thetha, "YBET", "YBET", 1000000, 0, xbet.address);
  const ybet = await thetha.deployed();

  xbet.transferowner(ybet.address);
  ybet.transfer("0x5961B58E4B5f9589C28b384e4b42705f5DCc701F", 10000);
};
