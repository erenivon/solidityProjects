// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
contract theDress{
     uint256 STEP = 5 minutes;
    // IERC20 private dressToken;
     uint256 public immutable_start_time;

     constructor(/*address tokenAddress*/) {
        //  dressToken = IERC20(tokenAddress);
         immutable_start_time = block.timestamp;
         PRICE = 1 ether/1000;
     }

     struct Voter {
        uint vote;
        bool votedBlue;
        bool votedGold;
    }
    
    struct Owner {
        bool blueWon;
        bool goldWon;
    }

    mapping(address => Voter) private _voters;
    mapping(address => Owner) private _owner;
    uint256 [2] voters;
    uint256 public totalGold;
    uint256 public totalBlue;
    uint256 public PRICE = 1 ether/1000;
    uint256 private OWNER_PERCENTAGE = 40;
    uint256 public TotalPaidToken;
    uint256 passingTime;
    uint256 timeDifference;
    uint256 total_ownerPercentage;
    address _chairperson = 0x6a411Be2a84eaf31d9F6092CA08F364Fb9Fe1350;

    function voteBlue() public payable {
         Voter storage sender = _voters[msg.sender];
         totalBlue++;
         sender.votedBlue=true;
         TotalPaidToken +=PRICE;

    }

    function voteGold() public payable {
         Voter storage sender = _voters[msg.sender];
         totalGold++;
         sender.votedGold=true;
         TotalPaidToken +=PRICE;
    }

    function winner_share(uint256 whichColor) public {
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

    function withdraw() public {
        Owner storage chairperson = _owner[msg.sender];
        Voter storage sender = _voters[msg.sender];
        if(chairperson.goldWon==true){
        require(!sender.votedGold,"Gold is won but u are not woted gold!");
        total_ownerPercentage = TotalPaidToken * OWNER_PERCENTAGE/100;
        TotalPaidToken = total_ownerPercentage / (TotalPaidToken * 100);
         //transfer totelpaidtoken
        }
        else{
        require(!sender.votedBlue,"Blue is won but u are not woted gold!");
        total_ownerPercentage = TotalPaidToken * OWNER_PERCENTAGE/100;
        TotalPaidToken = total_ownerPercentage / (TotalPaidToken * 100);
        //transfer totelpaidtoken
        }
    }
}
