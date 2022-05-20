// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract AirConditioing
{
   uint256 [] public paidToken;
   uint256 [] public ac; //klima
   uint256 [] public ac_degree; //derece
   address [] public wallet; //klima sahibi
      
   //
   ////////////MAIN////////////
   function setAcOwner(uint256 _ac,uint256 tokenValue , uint256 _degree ) public returns(uint256)
   {
    require(ac[_ac]>0&&ac[_ac]<5,"We only have 4 air conditioners :( Please choose between 1-4.");
    require(paidToken[_ac]<tokenValue,"Don't be afraid to take risks, increase the price :)");
    paidToken[_ac]=tokenValue;
    ac_degree[_ac]=_degree;
    wallet[_ac] = msg.sender;
    return paidToken[_ac];
   }

   function SetDegree(uint256 _ac , uint256 _degree) public 
    {
        require(ac[_ac]>0&&ac[_ac]<5,"We only have 4 air conditioners :( Please choose between 1-4.");
        require(wallet[_ac] == msg.sender, "The owner of the air conditioner does not appear here.");
        require(_degree>15&&_degree<31,"Values must be between 16-30.");
        ac_degree[_ac]=_degree;
    }
}
