// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from 'forge-std/Script.sol';
import {IPoolConfigurator} from '../src/contracts/interfaces/IPoolConfigurator.sol';

contract DropReservesScript is Script {
  function run() external {
    address configurator = 0x25C75e44A582548A34368B6321E115AC22796c44;

    address[] memory assets = new address[](3);
    assets[0] = 0xe1ee70321F835753635d5a419e01A4C20d1D066D;
    assets[1] = 0xa19328F2c3A6D75E7ABce5F919a1cEF8Dc4E6173;
    assets[2] = 0x59af20A40E7f9341d164b723A30685AE6d5c6fBb;

    vm.startBroadcast();
    for (uint256 i; i < assets.length; ++i) {
      IPoolConfigurator(configurator).dropReserve(assets[i]);
    }
    vm.stopBroadcast();
  }
}
