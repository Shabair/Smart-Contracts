// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Lottery {
    address manager;
    address payable[] public participants;

    modifier onlyManager() {
        require(msg.sender == manager, "Only Manager Allowed");
        _;
    }

    constructor() {
        manager = msg.sender;
    }

    receive() external payable {
        // require(msg.value >= 1 ether,"Insufficient Balance");
        participants.push(payable(msg.sender));
    }

    function getBalance() public view onlyManager returns (uint256) {
        return address(this).balance;
    }

    function random() internal view returns (uint256) {
        return
            uint256(
                keccak256(
                    abi.encodePacked(
                        block.difficulty,
                        block.timestamp,
                        participants.length,
                        msg.sender,
                        blockhash(block.number)
                    )
                )
            );
    }

    function selectWinner() public onlyManager {
        require(participants.length >= 3);
        address payable winner;
        uint256 participantIndex = random() % participants.length;
        winner = participants[participantIndex];
        winner.transfer(getBalance());
        participants = new address payable[](0);
    }
}
