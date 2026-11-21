// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

/// @title DeployMoodNft
/// @notice Foundry script for deploying the MoodNft collection with SVG image assets.
contract DeployMoodNft is Script {
    /// @notice Reads the SVG assets, converts them to data URIs, and deploys MoodNft.
    /// @return moodNft The newly deployed collection.
    function run() external returns (MoodNft) {
        string memory sadSvg = vm.readFile("./img/sad.svg");
        string memory happySvg = vm.readFile("./img/happy.svg");

        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(svgToImageURI(sadSvg), svgToImageURI(happySvg));
        vm.stopBroadcast();
        return moodNft;
    }

    /// @notice Encodes SVG markup as a Base64 image data URI.
    /// @param svg The raw SVG markup to encode.
    /// @return imageURI The SVG data URI.
    function svgToImageURI(string memory svg) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}
