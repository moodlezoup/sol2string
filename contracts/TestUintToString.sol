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
        str = uint2str(n);
        gasCost = g0 - gasleft();
    }


    /// @dev Baseline uint256 to string implementation, from
    ///      https://github.com/dapp-org/tinlake-tests/blob/main/src/utils.sol#L9
    /// @param _i The integer to convert.
    /// @return _uintAsString `_i` as a decimal string.
    function uint2str(uint _i) 
        internal 
        pure 
        returns (string memory _uintAsString) 
    {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len;
        while (_i != 0) {
            k = k-1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }
}
