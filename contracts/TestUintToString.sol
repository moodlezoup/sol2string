//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./LibUintToString.sol";

contract TestUintToString {
    using LibUintToString for uint256;

    /// @dev Converts `n` to a string using LibUintToString and 
    ///      measures the gas cost.
    /// @param n The integer to convert.
    /// @return str `n` as a decimal string.
    /// @return gasCost The gas cost of the conversion.
    function testToString(uint256 n)
        public 
        view 
        returns (string memory str, uint256 gasCost) 
    {
        uint256 g0 = gasleft();
        str = n.toString();
        gasCost = g0 - gasleft();
    }

    /// @dev Converts `n` to a string using the baseline implementation
    ///     (`uint2str`) and measures the gas cost.
    /// @param n The integer to convert.
    /// @return str `n` as a decimal string.
    /// @return gasCost The gas cost of the conversion.
    function baselineToString(uint256 n)
        public 
        view 
        returns (string memory str, uint256 gasCost) 
    {
        uint256 g0 = gasleft();
        str = toStringOZ(n);
        gasCost = g0 - gasleft();
    }


    /// @dev Baseline uint256 to string implementation, from OpenZeppelin
    ///      https://github.com/OpenZeppelin/openzeppelin-contracts/blob/788d338c9b53d57f7229f79815573dcb91ecede1/contracts/utils/Strings.sol#L14
    /// @param value The integer to convert.
    /// @return str The `value` as a decimal string.
    function toStringOZ(uint256 value) 
        internal 
        pure 
        returns (string memory str) 
    {
        // Inspired by OraclizeAPI's implementation - MIT licence
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}
