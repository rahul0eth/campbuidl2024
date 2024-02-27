// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// used to mint an NFT for buidl-portfolio-main (day 4) testing

contract MyFirstNFT{
    //owner mapping
    mapping(uint => address) owners;

    //mapping of traits
    mapping(uint => string) traits;

    //keeps track of nft counter
    uint counter;

    // init owner
    address owner;

    constructor(){
        counter = 0;
        owner = msg.sender;
    }

    //mint function to create new NFT
    //assign function

    function mint(string memory _trait) external {
        require(msg.sender == owner);
        owners[counter] = msg.sender;
        
        traits[counter] = _trait;

        counter++;
    }

    //transfer
    function transfer(address _to, uint _id) external {
        require(msg.sender == owners[_id], "You're not the owner!");
        owners[_id] = _to;        
    }

    //buy
    function buy() external payable {
        require(msg.value >= 1 ether/1000);

        owners[counter] = msg.sender;
        
        traits[counter] = string("Great Value!"); //power

        counter++;
    }

    function ownerOf(uint _id) external view returns(address) {
        return owners[_id];
    }

    function getTraits(uint _id) external view returns(string memory){
        return traits[_id];
    }

}