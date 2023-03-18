// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract Lottery {
    address public manager;
    address payable[] public players;
    uint public minimumBet;
    uint public numTickets;

    constructor(uint _minimumBet, uint _numTickets) {
        manager = msg.sender;
        minimumBet = _minimumBet;
        numTickets = _numTickets;
    }

    function enter() public payable {
        require(msg.value >= minimumBet, "Not enough ether to enter the lottery.");
        require(players.length < numTickets, "The lottery is full.");

        players.push(payable(msg.sender));
    }

    function pickWinner() public restricted {
        require(players.length == numTickets, "The lottery is not full yet.");

        uint index = random() % numTickets;
        players[index].transfer(address(this).balance);

        // reset the lottery
        delete players;
    }

    function getPlayers() public view returns (address payable[] memory) {
        return players;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, players.length)));
    }

    modifier restricted() {
        require(msg.sender == manager, "Only the manager can call this function.");
        _;
    }
}
