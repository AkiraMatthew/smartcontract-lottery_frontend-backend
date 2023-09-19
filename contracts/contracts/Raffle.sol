// Raffle

// Enter the lottery(paying some amount)
// Pick a random winner (verifiably random)
// Winner to be selected every X minutes -> completly automated

// Chainlink Oracle -> Randomness, Automated Execution (Chainlink Keepers)

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

error Raffle__NotEnoughETHEntered();

contract Raffle {
    /* State Variables */
    uint256 private immutable i_entranceFee; // -> price to join the lottery pool
    address payable[] private s_players;

    /* Events */
    event RaffleEnter(address indexed player);

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
    }

    function enterRaffle() public payable {
        // require (msg.value > i_entranceFee, 'Not enough ETH')
        // revert for gas efficience
        if (msg.value < i_entranceFee) revert Raffle__NotEnoughETHEntered();
        s_players.push(payable(msg.sender));
        // Emit an event when we update a dynamic array or mapping
        // Named events with the function name reversed
        emit RaffleEnter(msg.sender);
    }

    //function pickRandomWinner(){}

    function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
    }

    function getPlayer(uint256 index) public view returns (address) {
        return s_players[index];
    }
}
