// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts/access/Ownable.sol";
contract theDress is Ownable {
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
    uint256 public totalGold;
    uint256 public totalBlue;
    uint256 timeDifference;
    uint256 total_ownerPercentage;
    uint256 public immutable start_time;
    address _chairperson = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    error InsufficientFunds();
    error InvalidWinnerID();
    error TransferTxError();

    constructor() {
        start_time = block.timestamp;
    }

     struct Voter {
        uint vote;
        bool votedBlue;
        bool votedGold;
    }
    mapping(address => Voter) private _voters;

    struct Owner {
        bool blueWon;
        bool goldWon;
    }
    mapping(address => Owner) private _owner;

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
        userBlue[msg.sender] += quantity;
        sender.votedBlue=true;
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
        userGold[msg.sender] += quantity;
        totalGold += quantity;
        Voter storage sender = _voters[msg.sender];
        sender.votedGold=true;
        updateShares();
    }

    function winner(uint256 whichColor) public {
        Owner storage chairperson = _owner[msg.sender];
        require(msg.sender==_chairperson,"U are not owner.");
        if(whichColor==1){
            chairperson.blueWon=false;
            chairperson.goldWon=true;
        }
        else{
            chairperson.blueWon=true;
            chairperson.goldWon=false;
        }
    }

    function ownerWithdraw() external onlyOwner {
        uint256 share = ownerShare;
        ownerShare = 0;
        (bool isSuccess, ) = payable(owner()).call{ value: share }("");
        if (!isSuccess) revert TransferTxError();
    }

    function winnerWithdraw() external {
        uint256 withdrawAmount;
        Owner storage chairperson = _owner[msg.sender];
        require(!chairperson.blueWon||!chairperson.goldWon,"Any dresses has not win!");
        Voter storage sender = _voters[msg.sender];
        require(!sender.votedGold||!sender.votedBlue,"You didn't vote for the winning dress!");
        if(chairperson.blueWon){
            withdrawAmount = (winnerShare * userBlue[msg.sender]) / totalGold;
            userBlue[msg.sender] = 0;
        }
        if(chairperson.goldWon){
            withdrawAmount = (winnerShare * userGold[msg.sender]) / totalGold;
            userGold[msg.sender] = 0;
        }
         (bool isSuccess, ) = payable(msg.sender).call{ value: withdrawAmount }(
            ""
        );
        if (!isSuccess) revert TransferTxError();
    }
}
