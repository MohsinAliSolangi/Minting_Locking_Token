// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract USDC is ERC20, ERC20Burnable, Pausable, Ownable {


    constructor() ERC20("USDC", "DS") {}
    


    uint256 percentage = 3000;
    mapping (address=>mapping(uint256=>pool)) public locked;
    uint256 public mintingId;
    
    struct pool {
    uint256 startTime; 
    uint256 endTime;
    uint256 Poolamount;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }
   
    function percentageAmount(uint256 amount) private view returns (uint256) {
        return (amount / 10000) * percentage;
    }


    function mint(uint256 amount) public onlyOwner {
    
        require(amount>=0,"please mint gratherthan 0 ether" );
       
        uint256 thirty = percentageAmount(amount*10**18);
        uint256 seventy = amount*10**18- thirty;
        _mint(msg.sender,thirty);
        _mint(address(this),seventy);
        mintingId++;
        uint256 temp = locked[msg.sender][mintingId].Poolamount;
        locked[msg.sender][mintingId]=pool(block.timestamp, block.timestamp+600, temp + seventy);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }

    function withdrawToken(uint256 mintedId) external {
        require(locked[msg.sender][mintedId].Poolamount>0,"You Did not do menting");
        require(block.timestamp>locked[msg.sender][mintedId].endTime,"please wait for 10 mints then you can withdraw");
        IERC20 tokenContract = IERC20(address(this));
        uint256 amountToBETransfer = locked[msg.sender][mintedId].Poolamount;
        locked[msg.sender][mintedId].Poolamount = 0;
        tokenContract.transfer(msg.sender, amountToBETransfer);

    }

    function cheekLockBalance(address addr, uint256 mintedId)public view returns(uint256){
        return (locked[addr][mintedId].Poolamount);
    }

    function cheekRemainTime(address addr,uint256 mintedId) public view returns(uint256){
       return locked[addr][mintedId].endTime - block.timestamp;
        
    }

    

}