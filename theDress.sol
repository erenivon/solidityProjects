// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";

contract theDress is Ownable {
    uint256 public totalGold;
    uint256 public totalBlue;
    mapping(address => uint256) public userGold;
    mapping(address => uint256) public userBlue;
    uint256 public constant PRICE = 1 ether / 100;
    uint256 public constant STEP = 5 minutes;
    uint256 public ownerShare;
    uint256 public winnerShare;
    uint256 public constant OWNER_PERCENTAGE = 40;
    uint256 private goldOrBlue = 2;
    uint256 private constant GOLD = 0;
    uint256 private constant BLUE = 1;

    uint256 public immutable start_time;

    error InsufficientFunds();
    error InvalidWinnerID();
    error TransferTxError();

    constructor() {
        start_time = block.timestamp;
    }

    function calculatePrice() internal view returns (uint256) {
        uint256 timeDif = block.timestamp - start_time;
        return PRICE + (timeDif / STEP) * 0.00001 ether;
    }

    function updateShares() private {
        ownerShare += (msg.value * OWNER_PERCENTAGE) / 100;
        winnerShare += (msg.value * (100 - OWNER_PERCENTAGE)) / 100;
    }

    function gold(uint256 quantity) external payable {
        uint256 enterPrice = calculatePrice();
        uint256 fullPrice = quantity * enterPrice;
        if (msg.value < fullPrice) revert InsufficientFunds();

        userGold[msg.sender] += quantity;
        totalGold += quantity;
        updateShares();
    }

    function blue(uint256 quantity) external payable {
        uint256 enterPrice = calculatePrice();
        uint256 fullPrice = quantity * enterPrice;
        if (msg.value < fullPrice) revert InsufficientFunds();

        userBlue[msg.sender] += quantity;
        totalBlue += quantity;
        updateShares();
    }

    function winner(uint256 winnerId) external onlyOwner {
        if (winnerId != GOLD && winnerId != BLUE) revert InvalidWinnerID();
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
        if (goldOrBlue == GOLD) {
            withdrawAmount = (winnerShare * userGold[msg.sender]) / totalGold;

            userGold[msg.sender] = 0;
        } 
        else {
            withdrawAmount = (winnerShare * userBlue[msg.sender]) / totalBlue;

            userBlue[msg.sender] = 0;
        }
        (bool isSuccess, ) = payable(msg.sender).call{ value: withdrawAmount }(
            ""
        );
        if (!isSuccess) revert TransferTxError();
    }
}
