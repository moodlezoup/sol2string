# sol2string

This repository contains a Solidity library `LibUintToString` for efficiently converting `uint256` values to strings.

## Run tests

```shell
npm install
npx hardhat compile
npx hardhat test
```

## Gas benchmark
[Gas benchmark results](gas_benchmark.txt), using [OpenZeppelin's implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/788d338c9b53d57f7229f79815573dcb91ecede1/contracts/utils/Strings.sol#L14) as a benchmark.