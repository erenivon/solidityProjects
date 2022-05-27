// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract SetAirConditioning {
     string private bixos;
    constructor(string memory _tryingText) {
        console.log(":", _tryingText);
        bixos = _tryingText;
    }
    uint256 [4] tokenAmount; uint256 [4] acDegree; address [4] wallet;

    function getAcDetail(uint256 acId) public view returns (address,uint256,uint256) {
        return (wallet[acId],tokenAmount[acId],acDegree[acId]);
    }

    function setAdmin(uint256 acId, uint256 tokenValue) public {
        require(acId<4,"We only have 4 air conditioners :( Please choose: 0-1-2-3.");
        require(tokenAmount[acId]<tokenValue,"Don't be afraid to take risks, increase the price :)");
        wallet[acId]= msg.sender;
        tokenAmount[acId] = tokenValue;
    }
    function setDegree(uint256 acId, uint256 _degree) public {
        require(acId<4,"We only have 4 air conditioners :( Please choose: 0-1-2-3.");
        //wallet[acId]=msg.sender;
        require(wallet[acId] == msg.sender, "The owner of the air conditioner does not appear here.");
        require(_degree>15&&_degree<33,"Values must be between 16-30.");
        acDegree[acId]=_degree;
    }

    function sum(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }
 }
