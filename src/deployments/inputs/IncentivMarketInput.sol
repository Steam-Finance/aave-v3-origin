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

    config.networkBaseTokenPriceInUsdProxyAggregator = 0xeC7C6AdcC867E1C22713D14797339750E36538E4;
    config
      .marketReferenceCurrencyPriceInUsdProxyAggregator = 0xeC7C6AdcC867E1C22713D14797339750E36538E4;
    config.marketId = 'Aave V3 Incentiv Testnet Market';
    config.oracleDecimals = 8;
    config.providerId = 1;
    config.flashLoanPremium = 10; // 0.1%
    config.treasury = deployer;
    config.baseCurrency = 0x9d9D7C8A6523c969c9D1A508764C280F8939813E; // iUSD

    return (roles, config, flags, deployedContracts);
  }
}
