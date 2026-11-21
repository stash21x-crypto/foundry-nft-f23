//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

/// @title MoodNft
/// @notice ERC-721 collection whose metadata image changes between happy and sad moods.
contract MoodNft is ERC721 {
    /// @notice The caller is not authorized to change the token's mood.
    error MoodNft__CantFlipMoodIfNotOwner();

    uint256 private s_tokenCounter;
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;

    /// @dev The visual mood used to select each token's metadata image.
    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private s_tokenIdToMood;

    /// @notice Creates the Mood NFT collection with its happy and sad image URIs.
    /// @param sadSvgImageUri The data URI of the sad SVG image.
    /// @param happySvgImageUri The data URI of the happy SVG image.
    constructor(string memory sadSvgImageUri, string memory happySvgImageUri) ERC721("Mood NFT", "MN") {
        s_tokenCounter = 0;
        s_sadSvgImageUri = sadSvgImageUri;
        s_happySvgImageUri = happySvgImageUri;
    }

    /// @notice Mints a new NFT to the caller with its mood initially set to happy.
    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    /// @notice Toggles a token between its happy and sad moods.
    /// @dev Reverts if the token does not exist or the caller is not authorized.
    /// @param tokenId The ID of the token whose mood should be changed.
    function flipMood(uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        if (!_isAuthorized(owner, msg.sender, tokenId)) {
            revert MoodNft__CantFlipMoodIfNotOwner();
        }
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    /// @dev Returns the prefix used to form Base64-encoded JSON metadata URIs.
    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    /// @notice Returns the token's Base64-encoded JSON metadata, including its current mood image.
    /// @param tokenId The ID of the token to query.
    /// @return The data URI containing the token's JSON metadata.
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageURI;
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = s_happySvgImageUri;
        } else {
            imageURI = s_sadSvgImageUri;
        }

        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name": "',
                            name(),
                            '", "description": "An NFT that reflects the owners mood.", "attributes": [{"trait_type": "moodiness", "value": 100}], "image": "',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }
}
