// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "../src/BasicNFT.sol";
import {DeployBasicNft} from "../script/DeployBasicNFT.s.sol";

contract BasicNFTTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;

    address public USER = makeAddr("user");
    string public constant PUG =
        "ipfs://bafybeigf6n7lwpoxy5rq3fym7kynp2u4awftr2qazzyufbwbsof4d2bvsq/?filename=FAS-Horizontal(2).png";

    // function setUp() public {
    //     deployer = new DeployBasicNft();
    //     address basicNftAddress = deployer.run(); // Get the contract's address
    //     basicNft = BasicNft(basicNftAddress); // Properly cast the address to a contract instance
    // }

    function setUp() public {
    deployer = new DeployBasicNft();
    address basicNftAddress = address(deployer.run()); // Explicitly cast to address
    basicNft = BasicNft(basicNftAddress);
}

    function testNameIsCorrect() public view {
        string memory expectedName = "Doggie";
        string memory actualName = basicNft.name();
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNFT(PUG); // Ensure mintNft function exists in BasicNft.sol

        assert(basicNft.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(PUG)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));
    }
}