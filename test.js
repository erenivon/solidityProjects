const { expect } = require("chai");
const { ethers } = require("hardhat");

require("@nomiclabs/hardhat-waffle");

describe("SetAirConditioning", function () {
  let contract;
  let owner;

  beforeEach(async function () {
    const SetAirConditioning = await ethers.getContractFactory("SetAirConditioning");
    const bixos = await SetAirConditioning.deploy("Life's Good");
    contract = await bixos.deployed();

    [owner] = await ethers.getSigners();
  });
  it("Should value = 10", async function () {
    const test = await contract.sum(5, 5);
    expect(test).to.equal(10);
  });
  it("Trying 4 commands via 'setAdmin' function", async function () {
    var i;
    for(i = 0; i < 4; i++) {
        const test = await contract.setAdmin(i, 100);
        expect(test);
    }
  });
  it("Trying 4 commands via 'getAcDetail' function'", async function () {
    for(i = 0; i < 4; i++) {
        const test = await contract.getAcDetail(i);
        expect(test);
    }
  });
  
//   it("Trying 'setDegree'", async function () {
//     const test = await contract.setDegree(1,16);
//     expect(test);
//   });
});
