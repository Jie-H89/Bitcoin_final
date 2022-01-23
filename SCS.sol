// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts@4.4.2/token/ERC1155/ERC1155.sol";

contract SCS is ERC1155 {
    string public company;
    string public date;
    uint256 public shares;
    address[] public founders;
    uint NFT_ID = 0;
    uint numConfirmationsRequired;
    
    constructor(string memory _comapny, string memory _date, uint256 _shares, address[] memory _founders, uint _numConfirmationsRequired)
     ERC1155("https://abcoathup.github.io/SampleERC1155/api/token/{id}.json" ){
    //genesis SCN 
        shares = _shares;
        _mint(msg.sender, NFT_ID, shares, "");

        numConfirmationsRequired = _numConfirmationsRequired;
        require(
            numConfirmationsRequired > 0 &&
                numConfirmationsRequired <= _founders.length,
            "invalid number of required confirmations"
        );


    }
    // ressiue
    function ressiue(address _owner, uint256 _burn_amount, uint256 _mint_amount) public{
        _burn(msg.sender, NFT_ID, _burn_amount);
        _mint(msg.sender, NFT_ID, _mint_amount, "");
        console.log("ressiue");
    }
    //Stock Transacting
    function transfer(address target, uint256 _amount) public {
        safeTransferFrom(msg.sender, target, NFT_ID, _amount, "");
        console.log("transfered");
    }
    //Stock Redemption
    function redeem(address target) public {
        safeTransferFrom(target, msg.sender, NFT_ID, 1, "");
        _burn(msg.sender, NFT_ID, 1);
        console.log("redeemed");
    }

}