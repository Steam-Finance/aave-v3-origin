// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from 'forge-std/Script.sol';
import {IAaveV3ConfigEngine as IEngine} from '../src/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {EngineFlags} from '../src/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IACLManager} from '../src/contracts/interfaces/IACLManager.sol';

contract InitiateIncentivReservesScript is Script {
  function run() external {
    address configEngine = 0x4825066dBdFbab33bdACe4Ee213afba2A9E9AB01;
    IACLManager aclManager = IACLManager(0x64a2C764eB35c248E38A111d7023a0201D857DE8);

    IEngine.Listing[] memory listings = new IEngine.Listing[](3);
    IEngine.PoolContext memory context = IEngine.PoolContext({
      networkName: 'Incentiv',
      networkAbbreviation: 'Incv'
    });

    // iETHt
    listings[0] = IEngine.Listing({
      asset: 0x05a98f1F2c69da3E04D023eBeD71E534DfA018E9,
      assetSymbol: 'iETHt',
      priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419,
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
      asset: 0xd47a86a2980cB709fB74d1bf5AFD7e415924b9d2,
      assetSymbol: 'iBTCt',
      priceFeed: 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c,
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
      asset: 0xE1b1dc71A92C67a51FEbaB13864b3018D86Cd204,
      assetSymbol: 'iUSDt',
      priceFeed: 0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6,
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
