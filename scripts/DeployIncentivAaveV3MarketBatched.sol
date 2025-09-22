// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {DeployAaveV3MarketBatchedBase} from './misc/DeployAaveV3MarketBatchedBase.sol';

import {IncentivMarketInput} from '../src/deployments/inputs/IncentivMarketInput.sol';

contract IncentivAaveV3Market is DeployAaveV3MarketBatchedBase, IncentivMarketInput {}
