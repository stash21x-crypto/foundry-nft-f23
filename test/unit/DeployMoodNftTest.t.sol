// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";

/// @title DeployMoodNftTest
/// @notice Tests converting SVG markup into a Base64 image data URI.
contract DeployMoodNftTest is Test {
    DeployMoodNft public deployer;

    function setUp() public {
        deployer = new DeployMoodNft();
    }

    function testConvertSvgToUri() public view {
        string memory expectedUri =
            "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj4KICAgIDx0ZXh0IHg9IjAiIHk9IjE1IiBmaWxsPSJibGFjayI+IGhpLCBZb3UgZGVjb2RlZCB0aGlzICEgPC90ZXh0Pgo8L3N2Zz4=";
        string memory svg =
            "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"500\" height=\"500\">\n    <text x=\"0\" y=\"15\" fill=\"black\"> hi, You decoded this ! </text>\n</svg>";
        string memory actualUri = deployer.svgToImageURI(svg);
        assert(keccak256(abi.encodePacked(actualUri)) == keccak256(abi.encodePacked(expectedUri)));
    }
}
