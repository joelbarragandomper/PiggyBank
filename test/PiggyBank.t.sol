// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {PiggyBank} from "../src/PiggyBank.sol";

contract PiggyBankTest is Test {
    PiggyBank piggyBank;
    address user = address(0x1);

    function setUp() public {
        piggyBank = new PiggyBank();
        vm.deal(user, 10 ether);
    }

    function test_Deposit() public {
        vm.prank(user);
        piggyBank.deposit{value: 1 ether}();

        assertEq(piggyBank.account(user), 1 ether);
        assertEq(piggyBank.balanceOf(), 1 ether);
    }

    function test_onlyOwnerCanWithdraw() public {
        vm.prank(user);
        piggyBank.deposit{value: 1 ether}();

        vm.prank(user);
        vm.expectRevert("Only the owner can call this function");
        piggyBank.withdrawAll();
    }
}
