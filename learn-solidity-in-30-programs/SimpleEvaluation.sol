// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

contract day4 {
    function evaluate(int256 x, int256 y) public pure returns (int256){
    return ((x+y) - (x-y));
}

}
