// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;

    address public _przemo = makeAddr("Przemo");
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

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

    function testCanMintAndHaveBalance() public {
        vm.prank(_przemo);
        basicNft.mintNft(PUG);

        assert(basicNft.balanceOf(_przemo) == 1);
        assert(
            keccak256(abi.encodePacked(PUG)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}
