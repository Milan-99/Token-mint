var ybet = artifacts.require("./tfuel.sol");
var xbet = artifacts.require("./thetha.sol");

module.exports = async function (deployer) {
  await deployer.deploy(ybet, "YBET", "YBET", 0, 0);
  const y = await ybet.deployed();

  await deployer.deploy(XBET, "xBET", "XBET", 1000000, 0, y.address);
  const x = await thetha.deployed();

  y.transferowner(x.address);
  
};
