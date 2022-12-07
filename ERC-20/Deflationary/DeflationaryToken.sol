pragma solidity ^0.7.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

contract DeflationaryToken is ERC20 {
  // The total supply of tokens
  uint256 public totalSupply;

  // The address of the contract owner
  address private owner;

  // The deflation rate, expressed as a percentage
  uint8 private deflationRate;

  // Event to track when tokens are burned
  event Burned(uint256 amount);

  constructor(uint8 rate) public {
    // Set the owner of the contract to the address that deployed it
    owner = msg.sender;

    // Set the initial total supply to 0
    totalSupply = 0;

    // Set the deflation rate to the rate provided in the constructor
    deflationRate = rate;
  }

  // Override the ERC20 transfer function to include a burn on transfer
  function transfer(address recipient, uint256 amount) public override {
    // If the amount being transferred is greater than 0, burn some tokens
    if (amount > 0) {
      // Calculate the number of tokens to burn based on the deflation rate
      uint256 burnAmount = amount * (deflationRate / 100);

      // Burn the tokens by decreasing the total supply
      totalSupply -= burnAmount;

      // Transfer the remaining amount (after burning) to the recipient
      super.transfer(recipient, amount - burnAmount);

      // Emit the Burned event
      emit Burned(burnAmount);
    }
  }

  // Override the ERC20 transferFrom function to include a burn on transfer
  function transferFrom(address sender, address recipient, uint256 amount) public override {
    // If the amount being transferred is greater than 0, burn some tokens
    if (amount > 0) {
      // Calculate the number of tokens to burn based on the deflation rate
      uint256 burnAmount = amount * (deflationRate / 100);

      // Burn the tokens by decreasing the total supply
      totalSupply -= burnAmount;

      // Transfer the remaining amount (after burning) to the recipient
      super.transferFrom(sender, recipient, amount - burnAmount);

      // Emit the Burned event
      emit Burned(burnAmount);
    }
  }
}
