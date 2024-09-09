// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VulnerableAccessControl {
    address public owner;

    // Event to log when withdrawal occurs
    event Withdraw(address indexed owner, uint256 amount);

    constructor() payable {
        owner = msg.sender; // Set the deployer as the contract owner
    }

    // Modifier meant to restrict function access to the owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner!");
        _;
    }

    // FLAW: Incorrect modifier application, this should have used 'onlyOwner'
    function withdraw() public {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds available!");

        // Allow anyone to withdraw due to missing access control
        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Withdrawal failed");

        emit Withdraw(msg.sender, balance);
    }

    // Function to deposit ETH into the contract
    function deposit() public payable {}

    // Function to transfer ownership (this is fine and uses correct access control)
    function transferOwnership(address newOwner) public {
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
    }
}
