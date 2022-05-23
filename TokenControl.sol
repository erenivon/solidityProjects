// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol"; // 1. satir
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract TokenControl is ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    IERC20 private _ubxsToken; // 2. satir
    address private _contractAddress;

    constructor(address tokenAddress) ERC721("Bixos Air Control", "BSXAIR") {
        _contractAddress = address(this);
        _ubxsToken = IERC20(tokenAddress); // 3. satir
    }

    function mint(uint256 payUbxs) external {
        // slither-disable-next-line reentrancy-no-eth
        // require(payUbxs > oldHighPrice, "Error");

        require( // 4. satir
            _ubxsToken.transferFrom(msg.sender, _contractAddress, payUbxs ),
            "Transaction Error"
        );

        _tokenIdCounter.increment();

        _mint(msg.sender, _tokenIdCounter.current());
    }
}
