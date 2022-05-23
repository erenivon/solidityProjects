// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

//token olusturma islemleri burada yapilmakta token yonetimi icin ayri bir conractta calismaktadir..!
contract CreatedToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("Bixos Air Control", "BSXAIR") {
        _mint(_msgSender(), initialSupply);
    }

    function decimals() public pure override returns (uint8) {
        return 6;
    }
}
