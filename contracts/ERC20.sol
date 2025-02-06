// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import './libs/Events.sol';
import './libs/Errors.sol';
// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract ERC20 {

    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    mapping(address => uint256) _balances;
    mapping(address => mapping(address => uint256)) allowances;

    constructor(
        string memory name_,
        string memory symbol_,
        uint8 decimals_,
        uint256 totalSupply_
    ) {

       name = name_;
       symbol = symbol_;
       decimals = decimals_;
       totalSupply = totalSupply_;
       _balances[msg.sender] = totalSupply_;
    }

    function balanceOf(address owner_) public view returns (uint256 balance) {
        balance = _balances[owner_];
    }

    function transfer(address _to, uint256 _value) public  returns (bool success) {
        if(_to == address(0)) revert Errors.ERC20InvalidReceiver(address(0));
        if(_balances[msg.sender] < _value) revert Errors.ERC20InsufficientBalance(_balances[msg.sender], _value);

        _balances[msg.sender] -= _value;
        _balances[_to] += _value;

        emit Events.Transfer(msg.sender, _to, _value);

        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        if (_spender == address(0)) revert Errors.ERC20InvalidReceiver(_spender);
        allowances[msg.sender][_spender] = _value;
        emit Events.Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256) {
       return allowances[_owner][_spender];   
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        if (_to == address(0)) revert Errors.ERC20InvalidReceiver(_to);

        uint256 balanceOfFrom = _balances[_from];
        uint256 spendersAllowance = allowances[_from][msg.sender];
        
        if(balanceOfFrom < _value) revert Errors.ERC20InsufficientBalance(balanceOfFrom, _value);
        if(_value > spendersAllowance) revert Errors.ERC20InsufficientAllowance(msg.sender, spendersAllowance, _value); 

        _balances[_from] -= _value;
        _balances[_to] += _value;
        allowances[_from][msg.sender] -= _value;

        emit Events.Transfer(_from,  _to, _value);

        return true;

    }

}
