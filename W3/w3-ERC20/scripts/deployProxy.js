const { ethers, upgrades } = require('hardhat');

async function main() {
  const DanielTamV1 = await ethers.getContractFactory('DanielTamV1');
  const proxy = await upgrades.deployProxy(DanielTamV1, [100]);
  await proxy.deployed();

  const implementationAddress = await upgrades.erc1967.getImplementationAddress(
    proxy.address
  );

  console.log('Proxy contract address: ' + proxy.address);

  console.log('Implementation contract address: ' + implementationAddress);
}

main();