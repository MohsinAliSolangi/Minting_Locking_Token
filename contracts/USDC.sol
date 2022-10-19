// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract USDC is ERC20, ERC20Burnable, Pausable, Ownable {
    constructor() ERC20("USDC", "DS") {}
    
    uint256 percentage = 3000;
    mapping (address=>pool) public locked;
    
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
        uint256 temp = locked[msg.sender].Poolamount;
        locked[msg.sender]=pool(block.timestamp, block.timestamp+600, temp + seventy);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }

    function withdrawToken() external {
        require(locked[msg.sender].Poolamount>0,"You Did not do menting");
        require(block.timestamp>locked[msg.sender].endTime,"please wait for 10 mints then you can withdraw");
        IERC20 tokenContract = IERC20(address(this));
        uint256 amountToBETransfer = locked[msg.sender].Poolamount;
        locked[msg.sender].Poolamount = 0;
        tokenContract.transfer(msg.sender, amountToBETransfer);

    }

    function cheekLockBalance()public view returns(uint256){
        return (locked[msg.sender].Poolamount);
    }

    function cheekRemainTime() public view returns(uint256){
        uint256 time= locked[msg.sender].endTime - block.timestamp;
        if(time < 0)
        {
            return 0;
        }

        else
        {
            return time;
        }

}