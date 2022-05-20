// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract AirConditioing
{
   uint256 [4] public paidToken;
   uint256 [4] ac; //klima
   uint256 [4] public ac_degree; //derece
   address [4] public wallet; //klima sahibi
      
   //
   ////////////MAIN////////////
   function setAcOwner(uint256 selectedAC,uint256 tokenValue , uint256 _degree ) public returns(uint256)
   {
    require(selectedAC>0&&selectedAC<5,"We only have 4 air conditioners :( Please choose between 1-4.");
    require(paidToken[selectedAC]<tokenValue,"Don't be afraid to take risks, increase the price :)");
    paidToken[selectedAC]=tokenValue;
    ac_degree[selectedAC]=_degree;
    wallet[selectedAC] = msg.sender;
    return paidToken[selectedAC];
   }

   function SetDegree(uint256 selectedAC, uint256 _degree) public 
    {
        require(selectedAC>0&&selectedAC<5,"We only have 4 air conditioners :( Please choose between 1-4.");
        require(wallet[selectedAC] == msg.sender, "The owner of the air conditioner does not appear here.");
        require(_degree>15&&_degree<31,"Values must be between 16-30.");
        ac_degree[selectedAC]=_degree;
    }
}
