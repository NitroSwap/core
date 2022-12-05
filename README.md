# NitroSwap V1

## High-Level Overview

NitroSwap is a decentralized protocol for margin trading on top of AMMs such as Uniswap and Curve.

## Usage

### To Compile and Run Tests

1. Create .env file with api key

```
INFURA_API_KEY='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'

```

2. Run yarn commands to compile and test

### To Run Brownie Tests

```

```

### To Run Forge Tests

```
forge install
forge build
forge test
```

### To Deploy

Fill out parameters in `script/deployParameters/<network>.json`

```
forge script --broadcast \
--rpc-url <RPC-URL> \
--private-key <PRIVATE_KEY> \
--sig 'run(string)' \
script/Counter.s.sol:Counter \
<pathToJSON>
```

### To Deploy and Verify

```
forge script --broadcast \
--rpc-url <RPC-URL> \
--private-key <PRIVATE-KEY> \
--sig 'run(string)' \
script/Counter.s.sol:Counter \
<pathToJSON> \
--chain-id <CHAIN-ID>
--etherscan-api-key <ETHERSCAN-API-KEY> \
--verify
```
