// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PriceOracle {
    uint256 public btcUsdPrice;
    address public owner;

    event PriceUpdated(uint256 newPrice);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function updatePrice(uint256 _newPrice) external onlyOwner {
        btcUsdPrice = _newPrice;
        emit PriceUpdated(_newPrice);
    }

    function getPrice() external view returns (uint256) {
        return btcUsdPrice;
    }
}