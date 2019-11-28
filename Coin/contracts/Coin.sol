pragma solidity ^0.5.8;
contract Coin {
    // The keyword "public" makes those variables
    // readable from outside.
    address public minter;
    mapping (address => uint) public balances;

    // Events allow light clients to react on
    // changes efficiently.
    event Sent(address from, address to, uint amount);

    // This is the constructor whose code is
    // run only when the contract is created.
    constructor() public {
        minter = msg.sender;
    }

    function mint(address receiver, uint amount) public {
        //Ensure that only the minter can mint fresh coins
	require(msg.sender == minter);

        balances[receiver] += amount;
    }

    function transfer(address receiver, uint amount) public {
        //Ensure the sender has sufficient balance
	require(balances[msg.sender] >= amount);

        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}
