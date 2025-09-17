// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './MarketInput.sol';

contract IncentivMarketInput is MarketInput {
  function _getMarketInput(
    address deployer
  )
    internal
    pure
    override
    returns (
      Roles memory roles,
      MarketConfig memory config,
      DeployFlags memory flags,
      MarketReport memory deployedContracts
    )
  {
    roles.marketOwner = deployer;
    roles.poolAdmin = deployer;
    roles.emergencyAdmin = deployer;

    // config.networkBaseTokenPriceInUsdProxyAggregator = 0xeC7C6AdcC867E1C22713D14797339750E36538E4;
    // config
    //   .marketReferenceCurrencyPriceInUsdProxyAggregator = 0xeC7C6AdcC867E1C22713D14797339750E36538E4;
    config.networkBaseTokenPriceInUsdProxyAggregator = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
    config
      .marketReferenceCurrencyPriceInUsdProxyAggregator = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
    config.marketId = 'Aave V3 Incentiv Testnet Market';
    config.oracleDecimals = 8;
    config.providerId = 1;
    config.flashLoanPremium = 0.0005e4;
    config.treasury = deployer;

    return (roles, config, flags, deployedContracts);
  }
}
