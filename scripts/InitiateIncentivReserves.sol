// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from 'forge-std/Script.sol';
import {IAaveV3ConfigEngine as IEngine} from '../src/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {EngineFlags} from '../src/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IACLManager} from '../src/contracts/interfaces/IACLManager.sol';

contract InitiateIncentivReservesScript is Script {
  function run() external {
    address configEngine = 0x2bfa618228C26D95EAbfE246B88b1afbA639AA76;
    IACLManager aclManager = IACLManager(0xE661e0fE93736B086382383EF8f5455289CB9356);

    IEngine.Listing[] memory listings = new IEngine.Listing[](3);
    IEngine.PoolContext memory context = IEngine.PoolContext({
      networkName: 'Incentiv Testnet',
      networkAbbreviation: 'IncvT'
    });

    // iETHt
    listings[0] = IEngine.Listing({
      asset: 0x155c53e433fdEc47996bab941230631A75Fd5c20, // default price feed
      assetSymbol: 'iETHt',
      priceFeed: 0xeC7C6AdcC867E1C22713D14797339750E36538E4,
      rateStrategyParams: IEngine.InterestRateInputData({
        optimalUsageRatio: 70_00,
        baseVariableBorrowRate: 1_00,
        variableRateSlope1: 5_00,
        variableRateSlope2: 14_00
      }),
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.DISABLED,
      ltv: 50_00,
      liqThreshold: 55_00,
      liqBonus: 10_00,
      reserveFactor: 20_00,
      supplyCap: 0,
      borrowCap: 0,
      debtCeiling: 0,
      liqProtocolFee: 50_00
    });

    // iBTCt
    listings[1] = IEngine.Listing({
      asset: 0x3125A9F6eCbFF61326A362fA59131B1Ea9a0479b,
      assetSymbol: 'iBTCt',
      priceFeed: 0x98DC6E90D4c2f212ed9d124aD2aFBa4833268633,
      rateStrategyParams: IEngine.InterestRateInputData({
        optimalUsageRatio: 55_00,
        baseVariableBorrowRate: 1_00,
        variableRateSlope1: 3_00,
        variableRateSlope2: 8_00
      }),
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.DISABLED,
      ltv: 50_00,
      liqThreshold: 55_00,
      liqBonus: 10_00,
      reserveFactor: 20_00,
      supplyCap: 0,
      borrowCap: 0,
      debtCeiling: 0,
      liqProtocolFee: 50_00
    });

    // iUSDt
    listings[2] = IEngine.Listing({
      asset: 0x9d9D7C8A6523c969c9D1A508764C280F8939813E,
      assetSymbol: 'iUSDt',
      priceFeed: 0xeC7C6AdcC867E1C22713D14797339750E36538E4, // default price feed (iETH)
      rateStrategyParams: IEngine.InterestRateInputData({
        optimalUsageRatio: 80_00,
        baseVariableBorrowRate: 2_00,
        variableRateSlope1: 8_00,
        variableRateSlope2: 30_00
      }),
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.DISABLED,
      ltv: 80_00,
      liqThreshold: 88_00,
      liqBonus: 10_00,
      reserveFactor: 20_00,
      supplyCap: 0,
      borrowCap: 0,
      debtCeiling: 0,
      liqProtocolFee: 50_00
    });

    vm.startBroadcast();
    aclManager.addPoolAdmin(configEngine);
    IEngine(configEngine).listAssets(context, listings);
    aclManager.removePoolAdmin(configEngine);
    vm.stopBroadcast();
  }
}
