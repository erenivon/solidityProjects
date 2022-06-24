// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
interface Blame {
    function getBlameDetail(uint256 _id) external view returns (string memory, uint256);
    function createBlame(string memory your_blame) external;
    function deleteBlame(uint256 blameId) external;
}

contract setBlame is Blame {
    uint256 constant PRICE = 10;
    IERC20 private blameCoin; 

    constructor(address payable tokenAddress) {
        blameCoin = IERC20(tokenAddress); 
    }
    string [] descBlame;
    uint256 uniqueId = 0;
    uint256 [] boosts;
     
    function getBlameDetail(uint256 _id) public view override returns (string memory, uint256) {
        return (descBlame[_id], boosts[_id]);
    }

     function createBlame(string memory your_blame) public override {
        require( 
            blameCoin.transferFrom(msg.sender, address(this), PRICE),
            "Transaction Error"
        );
        descBlame.push(your_blame);
        boosts.push(0);
        uniqueId++;
    }
    function deleteBlame(uint256 blameId) public override {
        require(blameId<=uniqueId,"There is no blame for the id you specified.");
        require( 
            blameCoin.transferFrom(msg.sender, address(this), PRICE * (PRICE + boosts[blameId]) / 5),
            "Transaction Error"
        );
        delete descBlame[blameId];
    }
    function boostBlame(uint256 _blameId, uint256 boostQuantity) public {
        require(_blameId<=uniqueId,"There is no blame for the id you specified.");
        require( 
            blameCoin.transferFrom(msg.sender, address(this), PRICE + 5),
            "Transaction Error"
        );
        boosts[_blameId] = boostQuantity;
    }
 }
