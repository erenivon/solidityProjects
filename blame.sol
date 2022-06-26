// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
interface Blame {
    function getBlameDetail(uint256 _id) external view returns (string memory, string memory, uint256);
    function createBlame(string memory userName, string memory yourBlame) external;
    function deleteBlame(uint256 blameId) external;
    function boostBlame(uint256 _blameId, uint256 boostQuantity) external;
}

contract theBlame is Blame {
    uint256 constant PRICE = 10000000;
    IERC20 private blameCoin; 

    constructor(address payable tokenAddress) {
        blameCoin = IERC20(tokenAddress); 
    }
    string [] descBlame;
    string[] users;
    uint256 uniqueId = 0;
    uint256 [] boosts;
     
    function getBlameDetail(uint256 _id) public view override returns (string memory, string memory, uint256) {
        return (users[_id],descBlame[_id], boosts[_id]);
    }

     function createBlame(string memory userName, string memory yourBlame) public override {
        require( 
            blameCoin.transferFrom(msg.sender, address(this), PRICE),
            "Transaction Error"
        );
        descBlame.push(yourBlame);
        users.push(userName);
        boosts.push(0);
        uniqueId++;
    }
    function deleteBlame(uint256 blameId) public override {
        require(blameId<=uniqueId,"There is no blame for the id you specified.");
        require( 
            blameCoin.transferFrom(msg.sender, address(this), (PRICE * (PRICE + (boosts[blameId] * 10**6))) / 5000000),
            "Transaction Error"
        );
        delete descBlame[blameId];
        delete users[blameId];
        delete boosts[blameId];
    }
    function boostBlame(uint256 _blameId, uint256 boostQuantity) public override {
        require(_blameId<=uniqueId,"There is no blame for the id you specified.");
        require( 
            blameCoin.transferFrom(msg.sender, address(this), PRICE + 5000000),
            "Transaction Error"
        );
        boosts[_blameId] = boostQuantity;
    }
 }
