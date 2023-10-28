// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public {
        string memory expectedName = "Dogie";

        string memory givenName = basicNft.name();

        console.log("expectedName", expectedName);
        console.log("givenName", givenName);

        assertEq(expectedName, givenName);

        // Work around to compare with == string types
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(givenName))
        );
    }

    function testSymbolIsCorrect() public {
        string memory givenSymbol = basicNft.symbol();
        assertEq(givenSymbol, "DOG");
    }
}
