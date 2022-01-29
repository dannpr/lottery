pragma solidity ^0.4.17;

contract Lottery {
    address public manager;
    address[] public players;

    //constructor
    function Lottery() public {
        manager = msg.sender;
    }

    //the one that enter in the lottery pay
    function enter() public payable {
        require(msg.value > .01 ether);

        players.push(msg.sender);
    }

    function random() private view returns (uint256) {
        //sha3 = keccak256
        //block : global variable of the block
        //difficulty : how challenging it's gonna be to seal the current block
        //unit(x) : transform the x in a integer
        //it's not really random
        return uint256(sha3(block.difficulty, now, players));
    }

    function pickWinner() public restricted {
        uint256 index = random() % players.length;
        players[index].transfer(this.balance);
        // on peut faire ca pour avoir le gagnant lastWinner : players[index];
        // the (0) is asking that the dynamic array have a initial size that is 0
        players = new address[](0);
    }

    //reduce the amount of code using modifier
    modifier restricted() {
        require(msg.sender == manager);
        _;
    }

    function getPlayers() public view returns (address[]) {
        return players;
    }
}
