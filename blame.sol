// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
interface Blame {
    function getBlameDetail() external view returns (string[] memory);
    function createBlame(string memory your_blame) external;

    event blameCreated(string newBlame);
}

contract setBlame is Blame{
    uint256 constant PRICE = 10;
    IERC20 private blameCoin; 

     constructor(address tokenAddress) {
         blameCoin = IERC20(tokenAddress); 
     }
    string [] descBlame;
     
    function getBlameDetail() public view override returns (string[] memory) {
        return (descBlame);
    }

     function createBlame(string memory your_blame) public override {
         require( 
             blameCoin.transferFrom(msg.sender, address(this), PRICE),
             "Transaction Error"
         );
        descBlame.push(your_blame);
        emit blameCreated(your_blame);
    }
 }
