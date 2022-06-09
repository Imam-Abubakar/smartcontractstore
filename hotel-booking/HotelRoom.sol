// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract HotelRoom {

    enum Statuses {
        Vacant,
        Occupied
    }

    Statuses public currStatus;

    event Occupy(address _occupant, uint _value);

    address payable owner;

    constructor(){
        owner = payable(msg.sender);
        currStatus = Statuses.Vacant;
    }

    modifier whileVacant {
        require(currStatus == Statuses.Vacant, "Currently Occupied");
        _;
    }

    modifier costs(uint _amount) {
        require(msg.value >= _amount, "Not enough ether");
        _;
    }

    function book() public payable whileVacant costs(1 ether) {
        //owner.transfer(msg.value);

        (bool sent, bytes memory data) = owner.call{value: msg.value}("");
        require(sent);

        currStatus = Statuses.Occupied;
        emit Occupy(msg.sender, msg.value);
    }

}
