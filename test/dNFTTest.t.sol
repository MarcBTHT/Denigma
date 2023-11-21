// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {DeploydNFT} from "../script/DeploydNFT.s.sol";
import {dNFT} from "../src/dNFT.sol";

contract TokenTest is Test {
    dNFT public dnft;
    DeploydNFT public deployer;
    
    address public bob = makeAddr("bob");
    address public alice = makeAddr("alice");
    address public PLAYER = makeAddr("player");
    uint256 public constant STARTING_USER_BALANCE = 100 ether;

    /** EVENTS */
    event UpdatePrice(uint256 _tokenId, uint256 _price);

    function setUp() public {
        deployer = new DeploydNFT();
        dnft = deployer.run();

        dnft.MintNFT(bob); // Minting a token to bob
        vm.deal(PLAYER, STARTING_USER_BALANCE);
    }

    function testBobBalance() public {
        assertEq(bob, dnft.ownerOf(0));
    }

    function testTransferBtoA() public {
        console.log(dnft.tokenURI(0));
        vm.prank(bob); 
        dnft.transferFrom(bob, alice, 0); 
        console.log(dnft.balanceOf(bob));
        vm.prank(alice); 
        dnft.transferFrom(alice, bob, 0); 
        console.log(dnft.getBuyNumber());
        console.log(dnft.tokenURI(0));
        assertEq(bob, dnft.ownerOf(0));
    }

    function testViewTokenURI() view public {
        console.log(dnft.tokenURI(0));
    }

    ///////////////////////////
    // Buy / Transfer / Sell //
    ///////////////////////////

    function testSetPrice() public {
        dnft.MintNFT(alice); //TokenID=1
        vm.prank(alice);
        dnft.setPrice(1, 100);
        assertEq(100, dnft.getPrice(1));
    }
    function testSetPriceOnlyOwner() public {
        vm.prank(alice);
        vm.expectRevert(dNFT.dNFT__NotTokenOwner.selector); 
        dnft.setPrice(0, 100);
    }
    function testEmitsEventOnSetPrice() public {
        dnft.MintNFT(alice);
        vm.prank(alice);
        vm.expectEmit(true,true,false,false, address(dnft)); 
        emit UpdatePrice(1,100); // The test pass if we have this emit with the next line
        dnft.setPrice(1, 100);
    }
    function testRemoveTokenSale() public {
        dnft.MintNFT(alice); //TokenID=1
        vm.prank(alice);
        dnft.setPrice(1, 100);
        vm.prank(alice);
        dnft.removeTokenSale(1);
        assertEq(0, dnft.getPrice(1));
    }
    function testRemoveTokenSaleAfterTransfer() public {
        dnft.MintNFT(alice); //TokenID=1
        vm.prank(alice);
        dnft.setPrice(1, 10 ether);
        assertEq(10 ether, dnft.getPrice(1));
        vm.prank(PLAYER);
        dnft.buyToken{value: 10 ether}(1);
        assertEq(0, dnft.getPrice(1));
    }
    function testBuyToken() public {
        dnft.MintNFT(alice); //TokenID=1
        vm.prank(alice);
        dnft.setPrice(1, 10 ether);
        vm.prank(PLAYER);
        dnft.buyToken{value: 10 ether}(1);
        assertEq(PLAYER, dnft.ownerOf(1));
    }
    function testSetApprovalWhensetPrice() public {
        dnft.MintNFT(alice); //TokenID=1
        dnft.MintNFT(alice); //TokenID=2
        vm.prank(alice);
        dnft.setPrice(1, 10 ether);
        vm.prank(alice);
        dnft.setPrice(2, 20 ether);
        assertEq(address(dnft), dnft.getApproved(1));
        assertEq(address(dnft), dnft.getApproved(2));
    }
    function testRevokApprovalWhenRemoveToken() public {
        dnft.MintNFT(alice); //TokenID=1
        vm.prank(alice);
        dnft.setPrice(1, 100);
        dnft.getApproved(1); //If no approval return 0x0
        vm.prank(alice);
        dnft.removeTokenSale(1);
        assertEq(address(0), dnft.getApproved(1));
    }
    function testBuyTokenIfTokenNotSell() public {
        dnft.MintNFT(alice); //TokenID=1
        vm.prank(PLAYER);
        vm.expectRevert(dNFT.dNFT__TokenNotForSale.selector); //We expect a revert because the token is not for sale
        dnft.buyToken{value: 10 ether}(1);
    }
    function testBuyTokenIfNotEnoughFunds() public {
        dnft.MintNFT(alice); //TokenID=1
        vm.prank(alice);
        dnft.setPrice(1, 100 ether);
        vm.prank(PLAYER);
        vm.expectRevert(dNFT.dNFT__NotEnoughFunds.selector); 
        dnft.buyToken{value: 10 ether}(1);
    }
    function testBuyTokenFundSellerAndContract() public {
        dnft.MintNFT(alice); //TokenID=1
        vm.prank(alice);
        dnft.setPrice(1, 10 ether);
        vm.prank(PLAYER);
        dnft.buyToken{value: 10 ether}(1);
        assertEq(9 ether, address(dnft).balance);
        assertEq(1 ether, alice.balance);
    }
    function testBuyTokenFundsByTokenId() public {
        dnft.MintNFT(alice); //TokenID=1
        vm.prank(bob);
        dnft.setPrice(0, 10 ether);
        vm.prank(alice);
        dnft.setPrice(1, 20 ether);
        vm.prank(PLAYER);
        dnft.buyToken{value: 10 ether}(0);
        dnft.buyToken{value: 20 ether}(1); //Player have TokenId 1 and 2 (balance alice = 2 eth)
        assertEq(dnft.getFundsByTokenId(0), 9 ether);
        assertEq(dnft.getFundsByTokenId(1), 18 ether);
        vm.prank(PLAYER);
        dnft.setPrice(0, 2 ether); //Token 1 = 2 eth
        vm.prank(alice);
        dnft.buyToken{value: 2 ether}(0);
        assertEq(alice, dnft.ownerOf(0)); //We check that the transfer works with successive purchases
        assertEq(dnft.getFundsByTokenId(0), 10.8 ether); // 9 + 1.8 (= 2 * 0.9)
    }
}