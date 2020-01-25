const { expect } = require('chai');

const Uniswap_ETH_cDAI = artifacts.require('UniSwap_ETH_CDAIZap');

contract('Uniswap_ETH_cDAI test', async (accounts) => {
  it('checking parameters', async () => {
    this.defizap = await Uniswap_ETH_cDAI.new();
    await this.defizap.initialize({
      from: accounts[0],
      value: 0,
    });
    expect(await this.defizap.NEWDAI_TOKEN_ADDRESS.call()).equal('0x6B175474E89094C44Da98b954EedeAC495271d0F');
    expect(await this.defizap.COMPOUND_TOKEN_ADDRESS.call()).equal('0x5d3a536E4D6DbD6114cc1Ead35777bAB948E3643');
    expect(await this.defizap.DAI_TOKEN_ADDRESS.call()).equal('0x6B175474E89094C44Da98b954EedeAC495271d0F');
    expect(await this.defizap.ETH_TOKEN_ADDRESS.call()).equal('0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE');
    expect(await this.defizap.isOwner.call()).equal(true);
  });
  it('lets invest', async () => {
    this.defizap = await Uniswap_ETH_cDAI.new();
    await this.defizap.initialize({
      from: accounts[0],
      value: 0,
    });
    var something = await this.defizap.send(1);
    expect(await this.defizap.send(1));
  });

  it('get return', async () => {
    this.defizap = await Uniswap_ETH_cDAI.new();
    await this.defizap.initialize({
      from: accounts[0],
      value: 0,
    });
    const res = await this.defizap.getReturn.call('0x6B175474E89094C44Da98b954EedeAC495271d0F','0x6B175474E89094C44Da98b954EedeAC495271d0F',10)
    console.log(res);
  });

  it('get max', async () => {
    this.defizap = await Uniswap_ETH_cDAI.new();
    await this.defizap.initialize({
      from: accounts[0],
      value: 0,
    });
    expect(await this.defizap.getMaxTokens.call('0x6B175474E89094C44Da98b954EedeAC495271d0F','0x6B175474E89094C44Da98b954EedeAC495271d0F',10));
  });

  it('redeem', async () => {
    this.defizap = await Uniswap_ETH_cDAI.new();
    await this.defizap.initialize({
      from: accounts[0],
      value: 0,
    });
    expect(await this.defizap.Redeem(accounts[0],10));
  });
});
