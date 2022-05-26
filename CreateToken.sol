// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract CreatedToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("Bixoe Air Conditioing", "BSXAIR") {
        _mint(_msgSender(), initialSupply);
    }

    function decimals() public pure override returns (uint8) {
        return 6;
    }
}
