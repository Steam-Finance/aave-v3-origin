// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from 'forge-std/Script.sol';
import {IPoolAddressesProvider} from '../src/contracts/interfaces/IPoolAddressesProvider.sol';

contract SetLiquidatorProxyScript is Script {
  function run() external {
    address poolAddressesProviderAddress = 0x9F68933A787aBAE0C098f8ae36374087378a9E32;
    address liquidatorProxy = 0xEbE0e7E409deAf1Da78e08F77012e6408863979f;

    vm.startBroadcast();
    IPoolAddressesProvider(poolAddressesProviderAddress).setLiquidatorProxy(liquidatorProxy);
    vm.stopBroadcast();
  }
}
