pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

contract PausableToken is ERC20 {
  // Boolean to track whether the token is paused or not
  bool private paused = false;

  // The address of the contract owner
  address private owner;

  // Event to track when the token is paused or unpaused
  event Paused(bool isPaused);

  constructor() public {
    // Set the owner of the contract to the address that deployed it
    owner = msg.sender;
  }

  // Function to pause the token
  function pause() public onlyOwner {
    // Set the paused flag to true
    paused = true;

    // Emit the Paused event
    emit Paused(true);
  }

  // Function to unpause the token
  function unpause() public onlyOwner {
    // Set the paused flag to false
    paused = false;

    // Emit the Paused event
    emit Paused(false);
  }

  // Override the ERC20 transfer function to include a check for the paused flag
  function transfer(address recipient, uint256 amount) public override {
    // If the token is paused, do not allow transfers
    require(!paused, "Token is paused");

    // Otherwise, continue with the transfer as normal
    super.transfer(recipient, amount);
  }

  // Override the ERC20 transferFrom function to include a check for the paused flag
  function transferFrom(address sender, address recipient, uint256 amount) public override {
    // If the token is paused, do not allow transfers
    require(!paused, "Token is paused");

    // Otherwise, continue with the transfer as normal
    super.transferFrom(sender, recipient, amount);
  }

  // Modifier to restrict access to only the contract owner
  modifier onlyOwner() {
    // If the caller is not the contract owner, revert the transaction
    require(msg.sender == owner, "Only the contract owner can perform this action");

    // Otherwise, allow the function to continue
    _;
  }
}
