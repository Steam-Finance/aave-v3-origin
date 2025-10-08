// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import '../../interfaces/IMarketReportTypes.sol';
import {AaveOracle} from '../../../contracts/misc/AaveOracle.sol';

contract AaveV3OracleProcedure {
  function _deployAaveOracle(
    uint16 oracleDecimals,
    address poolAddressesProvider,
    address baseCurrency
  ) internal returns (address) {
    address[] memory emptyArray;

    address aaveOracle = address(
      new AaveOracle(
        IPoolAddressesProvider(poolAddressesProvider),
        emptyArray,
        emptyArray,
        address(0),
        baseCurrency,
        10 ** oracleDecimals
      )
    );

    return aaveOracle;
  }
}
