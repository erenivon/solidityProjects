// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract theBlame {
    uint256 constant PRICE = 10000000;
    IERC20 private blameCoin; 

    constructor(address payable tokenAddress) {
        blameCoin = IERC20(tokenAddress); 
    }
    string [] descBlame;
    string [] users;
    uint256 public blameCount = 0;
    uint256 public arrayLength;
    uint256 [] boosts;
    uint256 [] blameId;

    error AlreadyClaimed();

    struct Claimer{
        bool claimed;
        uint256 earnedCoin;
    }
    mapping(address => Claimer) userClaimed;
    function getBlameDetail(uint256 _id) public view returns (string memory, string memory, uint256, uint256) {
        return (users[_id],descBlame[_id], boosts[_id], blameId[_id]);
    }

    function createBlame(string memory userName, string memory yourBlame) public {
        require( 
            blameCoin.transferFrom(msg.sender, address(this), PRICE),
            "Transaction Error"
        );
        descBlame.push(yourBlame);
        users.push(userName);
        boosts.push(0);
        blameId.push(blameCount);
        blameCount++;
        arrayLength++;
    }

    function deleteBlame(uint256 _blameId) public {
        Claimer storage user = userClaimed[msg.sender];
        uint256 lastprice = (PRICE * (PRICE + (boosts[_blameId] * 10**6))) / 5000000;
        require(_blameId<=blameCount,"There is no blame for the id you specified.");
        require( 
            blameCoin.transferFrom(msg.sender, address(this), lastprice),
            "Transaction Error"
        );
        user.earnedCoin += lastprice;
        delete descBlame[_blameId];
        delete users[_blameId];
        delete boosts[_blameId];
        blameCount--;
    }

    function boostBlame(uint256 __blameId) public {
        require(__blameId<=blameCount-1,"There is no blame for the id you specified.");
        require( 
            blameCoin.transferFrom(msg.sender, address(this), PRICE + 5000000),
            "Transaction Error"
        );
        boosts[__blameId]++;
    }

    function claimBlame() public {
        Claimer storage user = userClaimed[msg.sender];
        if(user.claimed==true){
          revert AlreadyClaimed();
        }else{
          require( 
          blameCoin.transferFrom(address(this), msg.sender, 50000000),
          "Transaction Error"
          );
          user.claimed=true;
        }
    }

    function witdhdrawEarnings() public {
        Claimer storage user = userClaimed[msg.sender];
        require( 
          blameCoin.transferFrom(address(this), msg.sender, user.earnedCoin * 10**6),
          "Transaction Error"
          );
        user.earnedCoin = 0;
    }
 }
