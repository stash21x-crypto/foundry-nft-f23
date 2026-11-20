// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/// @title BasicNft
/// @notice ERC-721 collection whose metadata URI is set when each NFT is minted.
contract BasicNft is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToUri;

    /// @notice Creates the Dogie NFT collection.
    constructor() ERC721("Dogie", "DOG") {
        s_tokenCounter = 0;
    }

    /// @notice Mints an NFT and assigns its metadata URI.
    /// @param tokenUri The metadata URI to associate with the new token.
    function mintNft(string memory tokenUri) public {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    /// @notice Returns the metadata URI for a minted token.
    /// @dev Reverts if `tokenId` does not exist.
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);
        return s_tokenIdToUri[tokenId];
    }
}
