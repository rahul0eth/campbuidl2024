// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract YieldFarm{
    // Reward Parameters

    // address public depositTokenAddress;
    // address public rewardTokenAddress;

    mapping(address => uint) timeOfLastDeposit;
    mapping(address => uint) depositAmount;

    ERC20 public depositToken;
    ERC20 public rewardToken;

    constructor(address _depositTokenAddress, address _rewardTokenAddress){
        depositToken = ERC20(_depositTokenAddress);   
        rewardToken = ERC20(_rewardTokenAddress);
    }

    function deposit(uint amount) public {
        depositToken.transferFrom(msg.sender, address(this), amount);

        // update internal variables
        timeOfLastDeposit[msg.sender] = block.timestamp;

        depositAmount[msg.sender] += amount;
    }

    // function withdraw(uint amount) public {

    // }

    function claim() public {
        // current reward token price * tokens earned / day * 356 = Yearly profit
        // (yearly profit / cost of initial deposit) * 100 = % yearly profit

        uint numberOfRewardTokensToGive = depositAmount[msg.sender] * 7 * (block.timestamp - timeOfLastDeposit[msg.sender]);

        rewardToken.transferFrom(address(this), msg.sender, numberOfRewardTokensToGive);
        
        timeOfLastDeposit[msg.sender] = block.timestamp;

    }
}