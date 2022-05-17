// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Test
{
 
   uint256 private thancurrent;
   uint256 private airconditioningselected;
   uint256 private degree;

   uint[5]airconditionings = [1, 2, 3, 4 ];
   function CreatedPay(uint256 value , uint256 airconditioning , uint256 
_degree) 
   public returns(uint256)
   {
    require(thancurrent<value,"new value must be greater than current");
    thancurrent = value;
    airconditioningselected = airconditioning;
    degree = _degree;
    return value;
    
   }

   function getThanCurrent() public view returns(uint256)
    {
       return thancurrent;
    }


    function getAirConditioningSelected() public view returns(uint256)
    {
       return airconditioningselected;
    }

    

    function getDegree() public view returns(uint256)
    {
       return degree;
    }

    

    function ChangeDegree(uint256 newdegree) public  returns(uint256)
    {
       degree=newdegree;
       return degree;
    }
     



}

