// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ProfileImageNft is ERC721, Ownable {
    using Counters for Counters.Counter;
    using String for uint256;

    Counters.Counter _tokenIdCounter;

    mapping(uint256 => string) _tokenURIs;

    struct RenderToken {
        uint256 tokenId;
        string uri;
        string space;
    }

    constructor() ERC721("ProfileImageNft", "PIMN", 18) {}

    function _setTokenURI(uint256 tokenId, string memory _tokenURIs) internal {
        _tokenURIs[tokenId] = _tokenURIs;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(_exists(tokenId), "URI does not exist");
        string memory uri = _tokenURIs[tokenId];
        return uri;
    }

    function getAllToken() public view returns (RenderToken[] memory) {
        uint256 latestId = _tokenIdCounter.current();
        RenderToken[] memory result = new RenderToken[](latestId);
        for (uint256 i = 0; i < latestId; i++) {
            if (_exists(i)) {
                string memory uri = _tokenURIs[i];
                result[i] = (RenderToken(i, uri, ""));
            }
        }
        return result;
    }

    function mint(address _to, string memory _tokenURI)
        public
        returns (uint256)
    {
        require(!_exists(_tokenURI), "URI already exists");
        uint256 tokenId = _tokenIdCounter.increment();
        _setTokenURI(tokenId, _tokenURI);
        _mint(_to, tokenId);
        return tokenId;
    }
}
