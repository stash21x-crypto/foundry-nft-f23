// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

/// @title MintBasicNft
/// @notice Foundry script for minting a BasicNft on the latest deployed collection.
contract MintBasicNft is Script {
    /// @notice IPFS metadata URI used for the minted pug NFT.
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    /// @notice Finds the most recent BasicNft deployment on the current chain and mints a pug NFT.
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployed);
    }

    /// @notice Broadcasts a mint transaction to the specified BasicNft contract.
    /// @param contractAddress The address of the deployed BasicNft contract.
    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(PUG);
        vm.stopBroadcast();
    }
}
