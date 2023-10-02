// Raffle

// Enter the lottery(paying some amount)
// Pick a random winner (verifiably random)
// Winner to be selected every X minutes -> completly automated

// Chainlink Oracle -> Randomness, Automated Execution (Chainlink Keepers)

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

import '@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol';

error Raffle__NotEnoughETHEntered();

contract Raffle is VRFConsumerBaseV2 {
    /* State Variables */
    uint256 private immutable i_entranceFee; // -> price to join the lottery pool
    address payable[] private s_players;

    /* Events */
    event RaffleEnter(address indexed player);

    /**
     *
     * @param vrfCoordinatorV2 the vrfCoordinatorV2 it's the contract
     * that does the random number verification
     */
    constructor(address vrfCoordinatorV2, uint256 entranceFee) VRFConsumerBaseV2(vrfCoordinatorV2) {
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

    function requestRandomWinner() external {
        // get the random number
        // when we get it, do something with it
        // Chainlink VRF it's a 2 transaction process
    }

    function fulfillRandomWords(
        uint256 requestId,
        uint256[] memory randomWords
    ) internal override {}

    /* View / Pure functions */
    function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
    }

    function getPlayer(uint256 index) public view returns (address) {
        return s_players[index];
    }
}
