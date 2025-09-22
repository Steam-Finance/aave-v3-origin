# Aave V3 Liquidator Whitelist via Proxy

## Overview

The liquidation flow has been updated to restrict access to the `liquidationCall` function. Instead of being callable by anyone, it can now **only be executed through a designated Liquidator Proxy contract**.

This proxy validates liquidators against a **Merkle tree-based whitelist** and forwards any asset transfers during the liquidation process. The change makes sure that **only an approved set of liquidators** are able to liquidate positions.

## Key Changes

### 1. `Pool.sol`

- Added the `onlyLiquidatorProxy` modifier:

  ```solidity
  modifier onlyLiquidatorProxy() {
    require(
      ADDRESSES_PROVIDER.getLiquidatorProxy() == _msgSender(),
      Errors.CallerNotLiquidatorProxy()
    );
    _;
  }
  ```

- Applied this modifier to `liquidationCall`:

  ```solidity
  function liquidationCall(
    address collateralAsset,
    address debtAsset,
    address borrower,
    uint256 debtToCover,
    bool receiveAToken
  ) public virtual override onlyLiquidatorProxy { ... }
  ```

**Effect:** `liquidationCall` can now only be executed by the Liquidator Proxy.

### 2. `PoolAddressesProvider.sol`

- Introduced getter and setter for the proxy contract:

  ```solidity
  function getLiquidatorProxy() external view override returns (address);

  function setLiquidatorProxy(
    address newLiquidatorProxy
  ) external override onlyOwner;
  ```

- Emits an event on proxy updates:

  ```solidity
  event LiquidatorProxyUpdated(
    address indexed oldAddress,
    address indexed newAddress
  );
  ```

**Effect:** Governance/owner can configure or update the authorized Liquidator Proxy.

## Motivation

- **Controlled Access:** Prevent arbitrary liquidations by restricting to a whitelist.
- **Flexibility:** Governance can update the proxy address if needed.
- **Security:** The proxy ensures only approved liquidators (via Merkle proofs) can execute liquidations, reducing risks of malicious actors.

## Testing

Additional tests were introduced to validate this new liquidation restriction:

- In `PoolAddressesProvider.t.sol`, tests confirm that governance can correctly configure and update the Liquidator Proxy address, and that the system reflects these changes as expected.

- In `Pool.Liquidations.t.sol`, tests ensure that only the designated proxy is permitted to perform liquidations, and that attempts by unauthorized addresses are properly rejected.

## Summary

Liquidations are now restricted to whitelisted liquidators operating through a proxy contract, providing stronger governance controls and enhanced oversight of liquidation activity within the Aave V3 Pool contract.
