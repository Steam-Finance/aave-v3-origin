// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from 'forge-std/Script.sol';
import {console} from 'forge-std/console.sol';
import {TestnetERC20} from '../src/contracts/mocks/testnet-helpers/TestnetERC20.sol';

contract DeployTestnetTokensScript is Script {
  function run() external {
    uint256 pk = vm.envUint('PRIVATE_KEY');
    address deployer = vm.addr(pk);

    vm.startBroadcast(pk);

    TestnetERC20 iETH = new TestnetERC20('iETH Testnet', 'iETHt', 18, deployer);
    iETH.mint(1_000_000e18);

    TestnetERC20 iBTC = new TestnetERC20('iBTC Testnet', 'iBTCt', 18, deployer);
    iBTC.mint(1_000_000e18);

    TestnetERC20 iUSD = new TestnetERC20('iUSD Testnet', 'iUSDt', 18, deployer);
    iUSD.mint(1_000_000e18);

    vm.stopBroadcast();

    console.log('iETHt', address(iETH));
    console.log('iBTCt', address(iBTC));
    console.log('iUSDt', address(iUSD));
  }
}
