pragma solidity ^0.7.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

contract InflationaryToken is ERC20 {
  // The total supply of tokens
  uint256 public totalSupply;

  // The address of the contract owner
  address private owner;

  // The inflation rate, expressed as a percentage
  uint8 private inflationRate;

  // Event to track when new tokens are minted
  event Minted(uint256 amount);

  constructor(uint8 rate) public {
    // Set the owner of the contract to the address that deployed it
    owner = msg.sender;

    // Set the initial total supply to 0
    totalSupply = 0;

    // Set the inflation rate to the rate provided in the constructor
    inflationRate = rate;
  }

  // Function to mint new tokens
  function mint() public onlyOwner {
    // Calculate the number of new tokens to mint based on the inflation rate
    uint256 newTokens = totalSupply * (inflationRate / 100);

    // Increase the total supply by the number of new tokens minted
    totalSupply += newTokens;

    // Transfer the new tokens to the contract owner
    _transfer(owner, newTokens);

    // Emit the Minted event
    emit Minted(newTokens);
  }

  // Modifier to restrict access to only the contract owner
  modifier onlyOwner() {
    // If the caller is not the contract owner, revert the transaction
    require(msg.sender == owner, "Only the contract owner can perform this action");

    // Otherwise, allow the function to continue
    _;
  }
}
