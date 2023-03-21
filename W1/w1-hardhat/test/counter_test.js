const { loadFixture } = require('@nomicfoundation/hardhat-network-helpers');
const { expect } = require('chai');

describe('Counter', function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployContractAndSetVariables() {
    const Counter = await ethers.getContractFactory('Counter');
    const counter = await Counter.deploy();
    const provider = ethers.provider;
    const [owner,notOwner] = await ethers.getSigners();
    console.log('Signer 1 address: ', owner.address);
    console.log('Signer 2 address: ', notOwner.address);
    let withdrawAmount = ethers.utils.parseUnits("1", "ether");

    return { counter, owner,notOwner, provider, withdrawAmount };
  }

  it('should deploy and set the owner correctly', async function () {
    const { counter, owner } = await loadFixture(deployContractAndSetVariables);
    expect(await counter.owner()).to.equal(owner.address);
  });

  it('should not withdraw more than 0.1eth', async function () {
    const { counter, withdrawAmount } = await loadFixture(deployContractAndSetVariables);
    await expect(counter.withdraw(withdrawAmount)).to.be.reverted;
  });

  it('counter Function should not be called by anyone other than owner', async function () {
    const { counter, notOwner, } = await loadFixture(deployContractAndSetVariables);
    await expect(counter.connect(notOwner).destroyFaucet()).to.be.reverted;
  });

});