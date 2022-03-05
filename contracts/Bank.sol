// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {
    address payable public owner;
    mapping(address => uint) public deposits;
    uint called;

    constructor() payable {
        owner = payable(msg.sender);
    }

    function deposit() public payable {
      deposits[msg.sender] += msg.value;
    }

    receive() external payable {
      deposits[msg.sender] += msg.value;
    }

    //transfer
    function transfereth(address toaddr) payable public returns (bool){
                require(toaddr != address(0));
                toaddr.call{value: msg.value}("");
                return true;
    }

    // Received
    fallback() external payable {
      deposits[msg.sender] += msg.value;
      called += 1;
    }

    function notDeposit() public {
        //deposits[msg.sender] += msg.value;
    }
    function withdraw() public {
        uint amount = address(this).balance;

        (bool success, ) = owner.call{value: amount}("");
        require(success, "Failed to send Ether");
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
