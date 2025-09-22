// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from 'forge-std/Script.sol';
import {IPoolAddressesProvider} from '../src/contracts/interfaces/IPoolAddressesProvider.sol';

contract SetLiquidatorProxyScript is Script {
  function run() external {
    address poolAddressesProviderAddress = 0xf8BC30F8Cde014Dd78688075e754b31FDECd67CE;
    address liquidatorProxy = 0x746fe6E87e221a4aDFc73d1cF0B43386245429D8;

    vm.startBroadcast();
    IPoolAddressesProvider(poolAddressesProviderAddress).setLiquidatorProxy(liquidatorProxy);
    vm.stopBroadcast();
  }
}
