pragma solidity ^0.7.4; 

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

contract HTLC {
  uint public startTime;
  uint public lockTime = 10000 seconds;
  string public secret; //remarkable 
  bytes32 public hash = 0x80a251a6ea594109ef28537c1c1e16c05aba0cd7643923acf1ec0389297c5bba;
  address public recipient;
  address public owner; 
  uint public amount; 
  IERC20 public token;

  constructor(address _recipient, address _token, uint _amount) { 
    recipient = _recipient;
    owner = msg.sender; 
    amount = _amount;
    token = IERC20(_token);
  } 

  // fund the contract with the token and initiate the start time
  function fund() external {
    startTime = block.timestamp;
    token.transferFrom(msg.sender, address(this), amount);
  }

  // withdraw with the secret
  function withdraw(string memory _secret) external { 
    require(keccak256(abi.encodePacked(_secret)) == hash, 'Wrong secret!');
    secret = _secret; // store the secret on the blockchain for Alice
    token.transfer(recipient, amount); 
  } 

  // refund if nobody sends the token within the period, time stamp is longer than the start and locked time
  function refund() external { 
    require(block.timestamp > startTime + lockTime, 'Too early!');
    token.transfer(owner, amount); 
  } 
}