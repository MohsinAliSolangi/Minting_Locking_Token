const { expect } = require("chai");

describe("Defi contract", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  let USDC
  let USDT
 
it("Deploy the contract ", async function(){
  
  [  per1, per2 ] = await ethers.getSigners();

  USDC = await hre.ethers.getContractFactory("USDC");
  USDT = await USDC.deploy(); 
  await USDT.deployed();
  console.log("smart contract deploy here ",USDT.address);

 }),


it("this is call to mint function ", async function(){

  const mint= await USDT.mint(1);
  const balance = await USDT.balanceOf(per1.address);
  const Contractbalance = await USDT.balanceOf(USDT.address);
  console.log("this is Contractbalance && : ",Contractbalance.toString());
  console.log("this is owner balance ## ",balance.toString());

})

it("This is cheekLocked balance test",async function(){
  const cheek = await USDT.cheekLockBalance();
  console.log("This is you lock balance :",cheek);
  const Contractbalance = await USDT.balanceOf(USDT.address);
  console.log("Contractbalance && : ",Contractbalance.toString());
})

it("2nd time call to mint function ", async function(){
  
  await network.provider.send("evm_increaseTime", [3600])
  await network.provider.send("evm_mine")
  const mint= await USDT.mint(1);
  const balance = await USDT.balanceOf(per1.address);
  const Contractbalance = await USDT.balanceOf(USDT.address);
  console.log("2nd time this is Contractbalance && : ",Contractbalance.toString());
  console.log("2nd time this is owner balance ## ",balance.toString());
  
})


it("This is cheekLocked balance test",async function(){
  const cheek = await USDT.cheekLockBalance();
  console.log("This is you lock balance :",cheek);
  const Contractbalance = await USDT.balanceOf(USDT.address);
  console.log("Contractbalance && : ",Contractbalance.toString());
})

// it("this call will fail because its not time for withdraw",async function(){
//   //await network.provider.send("evm_increaseTime", [3600])
//   //await network.provider.send("evm_mine")
//   const withdraw= await USDT.withdrawToken();
//   const balance = await USDT.balanceOf(per1.address);
//   const Contractbalance = await USDT.balanceOf(USDT.address);
//   console.log("after withdraw Contractbalance && : ",Contractbalance.toString());
//   console.log("after withdraw owner balance ## ",balance.toString());
// });

it("This is withdraw test",async function(){
  await network.provider.send("evm_increaseTime", [600])
  await network.provider.send("evm_mine")
  const withdraw= await USDT.withdrawToken(1);
  const balance = await USDT.balanceOf(per1.address);
  const Contractbalance = await USDT.balanceOf(USDT.address);
  console.log("after withdraw Contractbalance && : ",Contractbalance.toString());
  console.log("after withdraw owner balance ## ",balance.toString());
});

it("This is cheekLocked balance test",async function(){
  const cheek = await USDT.cheekLockBalance(1);
  console.log("This is you lock balance :",cheek);
  const Contractbalance = await USDT.balanceOf(USDT.address);
  console.log("Contractbalance && : ",Contractbalance.toString());
})


it("3rd time call to mint function ", async function(){
  
  await network.provider.send("evm_increaseTime", [3600])
  await network.provider.send("evm_mine")
  const mint= await USDT.mint(1);
  const balance = await USDT.balanceOf(per1.address);
  const Contractbalance = await USDT.balanceOf(USDT.address);
  console.log("2nd time this is Contractbalance && : ",Contractbalance.toString());
  console.log("2nd time this is owner balance ## ",balance.toString());
  
})

it("This is withdraw test",async function(){
  await network.provider.send("evm_increaseTime", [3600])
  await network.provider.send("evm_mine")
  const withdraw= await USDT.withdrawToken(1);
  const balance = await USDT.balanceOf(per1.address);
  const Contractbalance = await USDT.balanceOf(USDT.address);
  console.log("2nd time after withdraw Contractbalance && : ",Contractbalance.toString());
  console.log("2nd time after withdraw owner balance ## ",balance.toString());
});

it("This is cheekLocked balance test",async function(){
  const cheek = await USDT.cheekLockBalance(1);
  console.log("This is you lock balance :",cheek);
  const Contractbalance = await USDT.balanceOf(USDT.address);
  console.log("Contractbalance && : ",Contractbalance.toString());
})

    
    

    
});
