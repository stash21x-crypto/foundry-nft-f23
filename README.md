# Foundry NFT

![Smart Contract Development](https://img.shields.io/badge/Focus-Smart%20Contract%20Security-blue)
![Platform](https://img.shields.io/badge/Platform-Updraft-purple)
![Education](https://img.shields.io/badge/Learning-Cyfrin%20Updraft-orange)
![License](https://img.shields.io/badge/License-MIT%20License-lightgrey)

A Foundry project with two ERC-721 collections:

- `BasicNft` stores the metadata URI provided when an NFT is minted.
- `MoodNft` serves on-chain JSON metadata with a happy or sad SVG image.

## Requirements

- [Foundry](https://book.getfoundry.sh/getting-started/installation)

## Build, test, and format

```shell
forge build
forge test
forge fmt
```

## Deploy

Deploy `BasicNft` with:

```shell
forge script script/DeployBasicNft.s.sol:DeployBasicNft --rpc-url <rpc-url> --broadcast
```

Deploy `MoodNft` with:

```shell
forge script script/DeployMoodNft.s.sol:DeployMoodNft --rpc-url <rpc-url> --broadcast
```

The mood NFT deployment script reads `img/sad.svg` and `img/happy.svg`.

## Acknowledgements

Built following the [Cyfrin Updraft](https://updraft.cyfrin.io/) Foundry DeFi course by Patrick Collins.

---

## License

[MIT](https://opensource.org/licenses/MIT)
