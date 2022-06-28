// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract CreatedToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("Blame", "BLAME") {
        _mint(_msgSender(), initialSupply);
    }
    
    struct Claimer{
        bool claimed;
    }
    mapping(address => Claimer) public userClaimed;

    function decimals() public pure override returns (uint8) {
        return 6;
    }
    address[] wallets;
    function claimBlame() public {
        Claimer storage user = userClaimed[msg.sender];
        require(!user.claimed,"already cleamed");
        transfer(msg.sender,50000000);
    }  
}
