//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./LibUintToString.sol";

contract TestUintToString {
    using LibUintToString for uint256;

    function testToString(uint256 n)
        public 
        view 
        returns (string memory str, uint256 gasCost) 
    {
        uint256 g0 = gasleft();
        str = n.toString();
        gasCost = g0 - gasleft();
    }
}
