// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from 'forge-std/Script.sol';
import {IAaveV3ConfigEngine as IEngine} from '../src/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {EngineFlags} from '../src/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IACLManager} from '../src/contracts/interfaces/IACLManager.sol';

contract InitiateIncentivReservesScript is Script {
  function run() external {
    address configEngine = 0x753a489DC24699BF3978d918af137D8F519A0F62;
    IACLManager aclManager = IACLManager(0xF8d87638b47eFA27753094552aa14303c2359ba2);

    IEngine.Listing[] memory listings = new IEngine.Listing[](3);
    IEngine.PoolContext memory context = IEngine.PoolContext({
      networkName: 'Incentiv',
      networkAbbreviation: 'Incv'
    });

    // iETH
    listings[0] = IEngine.Listing({
      asset: 0xf03D78BccF823E9Ff3641C47f60e349E06367B0E,
      assetSymbol: 'iETH',
      priceFeed: 0xeC7C6AdcC867E1C22713D14797339750E36538E4, // default price feed
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

    // iBTC
    listings[1] = IEngine.Listing({
      asset: 0x82c4E1A8bE27651ea0F897B7F86115BDB4415c15,
      assetSymbol: 'iBTC',
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

    // iUSD
    listings[2] = IEngine.Listing({
      asset: 0xF9b7b39f7fb324f05b87c14AD3d978044e581558,
      assetSymbol: 'iUSD',
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
