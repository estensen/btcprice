// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/PriceOracle.sol";

contract PriceOracleTest is Test {
    PriceOracle public priceOracle;
    address public owner;
    address public addr1;

    event PriceUpdated(uint256 newPrice);
    

    function setUp() public {
        owner = address(this);
        addr1 = address(0x123);
        priceOracle = new PriceOracle();
    }

    function testPriceIsSetCorrectly() public view {
        assertEq(priceOracle.owner(), owner);
    }

    function testPriceUpdateByOwner() public {
        uint256 newPrice = 70000 * 10 ** 18;
        priceOracle.updatePrice(newPrice);
        assertEq(priceOracle.btcUsdPrice(), newPrice);
    }

    function testPriceUpdateEventEmitted() public {
        uint256 newPrice = 70000 * 10 ** 18;
        vm.expectEmit(true, true, false, true, address(priceOracle));
        emit PriceUpdated(newPrice);
        priceOracle.updatePrice(newPrice);
    }

    function testGetPrice() public {
        uint256 newPrice = 70000 * 10*18;
        priceOracle.updatePrice(newPrice);
        assertEq(priceOracle.getPrice(), newPrice);
    }
}
