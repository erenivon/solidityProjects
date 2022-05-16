// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.4.26;

contract shreyansh_05
{
  function get_output() public pure returns (string) 
  {
      return ("Hi, your contract ran successfully");
  }
  enum Status {
      AlreadyPaid,
      Pay
  }
  struct User {
      address uAdress;
      string uName;
      uint256 uPay;
      Status status;
  }
  function createPay(string _uName, uint256 _uPay)public returns(uint256) {
   require(_uPay>1,"1den yuksek bir rakam giriniz.");

   User memory user;
   user.uAdress = msg.sender;
   user.uName = _uName;
   user.uPay = _uPay;
  }
}
