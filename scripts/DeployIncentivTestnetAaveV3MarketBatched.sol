// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {DeployAaveV3MarketBatchedBase} from './misc/DeployAaveV3MarketBatchedBase.sol';

import {IncentivTestnetMarketInput} from '../src/deployments/inputs/IncentivTestnetMarketInput.sol';

contract IncentivTestnetAaveV3Market is DeployAaveV3MarketBatchedBase, IncentivTestnetMarketInput {}
