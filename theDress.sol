// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
contract theDress{
     uint256 FiveM = 5 minutes;
     IERC20 private dressToken;
     uint256 public createTime;
     uint256 public dressPrice;

     constructor(address tokenAddress) {
         dressToken = IERC20(tokenAddress);
         createTime = block.timestamp;
         dressPrice = (10**18)/100;
     }

     struct Voter {
        bool voted;
        uint vote;
    }

    mapping(address => Voter) private _voters;
    uint256 [2] voters;
    uint256 public TotalVoters;
    uint256 public TotalPaidToken;

    function voteDress(uint256 selectDress) public {
        Voter storage sender = _voters[msg.sender];
        require(selectDress<2,"We only have 2 dresses :( Please choose between 0-1.");
        require(!sender.voted, "You Already voted.");
        require( 
            dressToken.transferFrom(msg.sender, address(this), dressPrice),
             "Transaction Error"
        );
        sender.voted = true;
        sender.vote = selectDress;
        voters[selectDress]++;
        TotalPaidToken +=dressPrice;
        TotalVoters = voters[0]+voters[1];
    }
}
