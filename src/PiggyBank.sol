// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract PiggyBank {
    address public owner;
    mapping(address => uint256) public account;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed owner, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function deposit() public payable {
        require(msg.value > 0, "Desposit some ETH");

        account[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    function withdrawAll() public onlyOwner {
        uint256 amount = address(this).balance;
        require(amount > 0, "No ETH to withdraw");

        (bool exit,) = owner.call{value: amount}("");
        require(exit, "Failed to transfer ETH to owner");
        emit Withdrawn(owner, amount);
    }

    function balanceOf() public view returns (uint256) {
        return address(this).balance;
    }
}
