// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract eren
{
  //air1
   uint256 paidToken;
   uint256 selectedAir;
   uint256 degree;
  //air2
   uint256 paidToken2;
   uint256 selectedAir2;
   uint256 degree2;
   //air3
   uint256 paidToken3;
   uint256 selectedAir3;
   uint256 degree3;
   //air4
   uint256 paidToken4;
   uint256 selectedAir4;
   uint256 degree4;

   ////////////MAIN////////////

   function klima1(uint256 tokenValue , uint256 _degree) public returns(uint256)
   {
    /*require(airconditioning<5,"We only have 4 air conditioners :( Please choose between 1 and 4.");
    selectedAir = airconditioning;*/
    require(paidToken<tokenValue,"Don't be afraid to take risks, increase the price :)");
    paidToken = tokenValue;
    require(_degree>15&&_degree<31,"Values must be between 16 and 30.");
    degree = _degree;
    return tokenValue;
   }
   // uint256 airconditioning
   function klima2(uint256 tokenValue , uint256 _degree) public returns(uint256)
   {
   /* require(airconditioning<5,"We only have 4 air conditioners :( Please choose between 1 and 4.");
    selectedAir2 = airconditioning;*/
    require(paidToken2<tokenValue,"Don't be afraid to take risks, increase the price :)");
    paidToken2 = tokenValue;
    require(_degree>15&&_degree<31,"Values must be between 16 and 30.");
    degree2 = _degree;
    return tokenValue;
   }
   function klima3(uint256 tokenValue , uint256 _degree) public returns(uint256)
   {
    require(paidToken3<tokenValue,"Don't be afraid to take risks, increase the price :)");
    paidToken3 = tokenValue;
    require(_degree>15&&_degree<31,"Values must be between 16 and 30.");
    degree3 = _degree;
    return tokenValue;
   }
    function klima4(uint256 tokenValue , uint256 _degree) public returns(uint256)
   {
    require(paidToken4<tokenValue,"Don't be afraid to take risks, increase the price :)");
    paidToken4 = tokenValue;
    require(_degree>15&&_degree<31,"Values must be between 16 and 30.");
    degree4 = _degree;
    return tokenValue;
   }

   function air1() public view returns(uint256,uint256)
    {
       return (paidToken,degree);
    }
    function air2() public view returns(uint256,uint256)
    {
       return (paidToken2,degree2);
    }
     function air3() public view returns(uint256,uint256)
    {
       return (paidToken3,degree3);
    }
     function air4() public view returns(uint256,uint256)
    {
       return (paidToken4,degree4);
    }
}
