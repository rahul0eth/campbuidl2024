// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SoulboundNFT is ERC721, Ownable {
    uint256 public nextTokenId;
    mapping(uint256 => NFTMetadata) public nftMetadata;

    struct NFTMetadata {
        string name;
        string link;
        string image;
        address boundAddress;
    }

    constructor() ERC721("SoulboundNFT", "SBNFT") Ownable(msg.sender) {
        nextTokenId = 1;
    }

    function mint(string memory name, string memory link, string memory image, address boundAddress) external onlyOwner {
        require(boundAddress != address(0), "Invalid address");
        
        uint256 tokenId = nextTokenId;
        _safeMint(boundAddress, tokenId);
        
        nftMetadata[tokenId] = NFTMetadata({
            name: name,
            link: link,
            image: image,
            boundAddress: boundAddress
        });

        nextTokenId++;
    }

    function getNFTData(uint256 tokenId) external view returns (string memory, string memory, string memory, address) {
        NFTMetadata memory metadata = nftMetadata[tokenId];
        return (metadata.name, metadata.link, metadata.image, metadata.boundAddress);
    }
}