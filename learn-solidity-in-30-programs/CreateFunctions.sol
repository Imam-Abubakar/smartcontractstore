// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract task2{
    uint8 a=10;
    function returnStateVariable() public view returns (uint8) {
        return a;
    }
    function returnLocalVariable() public pure returns (uint8){
        uint8 b=20;
        return b;
    }

}
