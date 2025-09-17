// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from 'forge-std/Script.sol';
import {IAaveV3ConfigEngine as IEngine} from '../src/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {EngineFlags} from '../src/contracts/extensions/v3-config-engine/EngineFlags.sol';

contract InitReservesScript is Script {
  function run() external {
    address configEngine = 0xCaFE0aCa1Ae6f9A07A6e703640e9ac094e18bE5B;

    IEngine.Listing[] memory listings = new IEngine.Listing[](1);
    IEngine.PoolContext memory context = IEngine.PoolContext({
      networkName: 'Incentiv',
      networkAbbreviation: 'INT'
    });

    // USDC
    listings[0] = IEngine.Listing({
      asset: 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48,
      assetSymbol: 'USDC',
      priceFeed: 0x986b5E1e1755e3C2440e960477f25201B0a8bbD4,
      rateStrategyParams: IEngine.InterestRateInputData({
        optimalUsageRatio: 80_00,
        baseVariableBorrowRate: 25, // 0.25%
        variableRateSlope1: 3_00,
        variableRateSlope2: 75_00
      }),
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.DISABLED,
      ltv: 62_50,
      liqThreshold: 86_00,
      liqBonus: 5_00,
      reserveFactor: 10_00,
      supplyCap: 85_000,
      borrowCap: 60_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00
    });

    vm.startBroadcast();
    IEngine(configEngine).listAssets(context, listings);
    vm.stopBroadcast();
  }
}
