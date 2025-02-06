// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

library Errors {
    error ERC20INVALIDADDRESS();
    error ERC20InsufficientBalance(uint256 availableBalance, uint256 requiredFunds);
    error ERC20InvalidSender(address sender);
    error ERC20InvalidReceiver(address receiver);
    error ERC20InsufficientAllowance(address spender, uint256 allowance, uint256 needed);
    error ERC20InvalidApprover(address approver);
    error ERC20InvalidSpender(address spender);
}
