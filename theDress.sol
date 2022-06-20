// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts/access/Ownable.sol";
contract theDress is Ownable {
    uint256 public constant PRICE = 1 ether / 100;
    uint256 public constant STEP = 5 minutes;
    uint256 private constant GOLD = 0;
    uint256 private constant BLUE = 1;
    uint256 public constant OWNER_PERCENTAGE = 40;
    uint256 public ownerShare;
    uint256 public winnerShare;
    uint256 public totalGold;
    uint256 public totalBlue;
    uint256 private goldOrBlue = 2;
    uint256 public immutable start_time;
    uint256 timeDifference;
    uint256 total_ownerPercentage;
    address Owner;

    error InsufficientFunds();
    error InvalidWinnerID();
    error TransferTxError();

    constructor() {
        start_time = block.timestamp;
        Owner = msg.sender;
    }

     struct Voter {
        uint gold;
        uint blue;
    }

    mapping(address => Voter) public _voters;

    function calculatePrice() internal view returns (uint256) {
        uint256 timeDif = block.timestamp - start_time;
        return PRICE + (timeDif / STEP) * 0.00001 ether;
    }

    function blue(uint256 quantity) external payable {
        uint256 enterPrice = calculatePrice();
        uint256 fullPrice = quantity * enterPrice;
        if (msg.value < fullPrice) revert InsufficientFunds();
        Voter storage sender = _voters[msg.sender];
        totalBlue += quantity;
        sender.blue+=quantity;
        updateShares();
    }

    function updateShares() private {
        ownerShare += (msg.value * OWNER_PERCENTAGE) / 100;
        winnerShare += (msg.value * (100 - OWNER_PERCENTAGE)) / 100;
    }

    function gold(uint256 quantity) public payable {
        uint256 enterPrice = calculatePrice();
        uint256 fullPrice = quantity * enterPrice;
        if (msg.value < fullPrice) revert InsufficientFunds();
        totalGold += quantity;
        Voter storage sender = _voters[msg.sender];
        sender.gold+=quantity;
        updateShares();
    }

    function winner(uint256 winnerId) public {
        require(msg.sender==Owner,"U are not owner.");
        goldOrBlue = winnerId;
    }

    function ownerWithdraw() external onlyOwner {
        uint256 share = ownerShare;
        ownerShare = 0;
        (bool isSuccess, ) = payable(owner()).call{ value: share }("");
        if (!isSuccess) revert TransferTxError();
    }

    function winnerWithdraw() external {
        uint256 withdrawAmount;
        require(goldOrBlue!=2,"Any dresses has not win!");
        Voter storage sender = _voters[msg.sender];
        if (goldOrBlue == 0) {
            withdrawAmount = (winnerShare * sender.gold) / totalGold;
            sender.gold = 0;
        } else {
            withdrawAmount = (winnerShare * sender.blue) / totalBlue;
            sender.blue = 0;
        }
         (bool isSuccess, ) = payable(msg.sender).call{ value: withdrawAmount }(
            ""
        );
        if (!isSuccess) revert TransferTxError();
    }
}
