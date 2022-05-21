// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
interface AirConditioings {
    function getDegree(uint256 selectedAC) external view returns (uint256);
    function getAdmin(uint256 selectedAC) external view returns (address);
    function getTokenValue(uint256 selectedAC) external view returns (uint256);
    function setAdmin(uint256 selectedAC, uint256 tokenValue) external;
    function setDegree(uint256 selectedAC, uint256 _degree) external;
}

contract AirConditioingSettings is AirConditioings {
    uint256 [4] public paidToken; 
    uint256 [4] public ac; 
    uint256 [4] public ac_degree; 
    address [4] public wallet;
    function getTokenValue(uint256 selectedAC) public view override returns (uint256) {
        return paidToken[selectedAC];
    }
    function getAdmin(uint256 selectedAC) public view override returns (address) {
        return wallet[selectedAC];
    }
    function getDegree(uint256 selectedAC) public view override returns (uint256) {
        return ac_degree[selectedAC];
    }
   function setAdmin(uint256 selectedAC, uint256 tokenValue) public override {
       require(selectedAC>0&&selectedAC<5,"We only have 4 air conditioners :( Please choose between 1-4.");
        require(paidToken[selectedAC]<tokenValue,"Don't be afraid to take risks, increase the price :)");
        paidToken[selectedAC]=tokenValue; wallet[selectedAC] = msg.sender;
   }
   function setDegree(uint256 selectedAC, uint256 _degree) public override {
        require(selectedAC>0&&selectedAC<5,"We only have 4 air conditioners :( Please choose between 1-4.");
        require(wallet[selectedAC] == msg.sender, "The owner of the air conditioner does not appear here.");
        require(_degree>15&&_degree<33,"Values must be between 16-30.");
        ac_degree[selectedAC]=_degree;
   }
  
 }
/*contract SetAirConditioing
{
   uint256 [4] public paidToken; uint256 [4] ac; uint256 [4] public ac_degree; address [4] public wallet; 
   function SetAcOwner(uint256 selectedAC, uint256 tokenValue, uint256 _degree) external {
        require(selectedAC>0&&selectedAC<5,"We only have 4 air conditioners :( Please choose between 1-4.");
        require(paidToken[selectedAC]<tokenValue,"Don't be afraid to take risks, increase the price :)");
        paidToken[selectedAC]=tokenValue; ac_degree[selectedAC]=_degree; wallet[selectedAC] = msg.sender;
   }
   function SetAcDegree(uint256 selectedAC, uint256 _degree) external {
        require(selectedAC>0&&selectedAC<5,"We only have 4 air conditioners :( Please choose between 1-4.");
        require(wallet[selectedAC] == msg.sender, "The owner of the air conditioner does not appear here.");
        require(_degree>15&&_degree<33,"Values must be between 16-30.");
        ac_degree[selectedAC]=_degree;
    }
}*/
