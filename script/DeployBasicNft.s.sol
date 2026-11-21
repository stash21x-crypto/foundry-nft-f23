//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";

/// @title DeployBasicNft
/// @notice Foundry script for deploying the BasicNft collection.
contract DeployBasicNft is Script {
    /// @notice Deploys a BasicNft contract using the active broadcast configuration.
    /// @return basicNft The newly deployed collection.
    function run() external returns (BasicNft) {
        vm.startBroadcast();
        BasicNft basicNft = new BasicNft();
        vm.stopBroadcast();
        return basicNft;
    }
}
