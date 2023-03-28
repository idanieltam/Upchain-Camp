const { ethers, upgrades } = require('hardhat');

const proxyAddress = '0xaF1C84e92b1A295fC7D8f0D6bB0c7F39Befa174a';

async function main() {
  const DanielTamV2 = await ethers.getContractFactory('DanielTamV2');
  const upgraded = await upgrades.upgradeProxy(proxyAddress, DanielTamV2);

  const implementationAddress = await upgrades.erc1967.getImplementationAddress(
    proxyAddress
  );

  console.log("The current contract owner is: " + await upgraded.owner());
  console.log('Implementation contract address: ' + implementationAddress);
}

main();