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
        require(_blameId<=blameCount,"There is no blame for the id you specified.");
        require( 
            blameCoin.transferFrom(msg.sender, address(this), (PRICE * (PRICE + (boosts[_blameId] * 10**6))) / 5000000),
            "Transaction Error"
        );
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
 }
