// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {DeployedNFT} from "../script/DeployedNFT.s.sol";
import {dNFT} from "../src/dNFT.sol";

contract TokenTest is Test {
    dNFT public dnft;
    DeployedNFT public deployer;
    
    address public bob = makeAddr("bob");
    address public alice = makeAddr("alice");
    address public PLAYER = makeAddr("player");
    uint256 public constant STARTING_USER_BALANCE = 100 ether;

    /** EVENTS */
    event UpdatePrice(uint256 _tokenId, uint256 _price);
    event Winner(address indexed winner);
    event EnteredRaffle(address indexed player, uint256 raffleNumber, uint256 tokenId);

    function setUp() public {
        deployer = new DeployedNFT();
        dnft = deployer.run();

        dnft.MintNFT(bob); // Minting a token to bob
        vm.deal(PLAYER, STARTING_USER_BALANCE);
        vm.deal(alice, STARTING_USER_BALANCE);
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
        console.log(dnft.getBuyNumberByTokenId(0));
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
        assertEq(STARTING_USER_BALANCE+1 ether, alice.balance);
    }
    /** The Function has change (No more getFundsByTokenId) 
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
    } */
    /** No more use: Replace by pickWinner and FulFillRandomWords 
    function testReleaseFunds() public { 
        uint256 BUY1 = 50 ether;
        uint256 BUY2 = 5 ether;
        uint256 BUY3 = 10 ether;
        //Buy 1st time
        vm.prank(bob);
        dnft.setPrice(0, BUY1);
        vm.prank(PLAYER);
        dnft.buyToken{value: BUY1}(0); 
        console.log("Number buy; ", dnft.getBuyNumberByTokenId(0));//s_buyNumberByTokenId[0]=1;
        console.log("Balance bob: ", bob.balance);
        console.log("Balance contract: ", address(dnft).balance); // =BUY1*0.9 (=45)
        //Buy 2nd time
        vm.prank(PLAYER);
        dnft.setPrice(0, BUY2);
        vm.prank(bob);
        dnft.buyToken{value: BUY2}(0); //s_buyNumberByTokenId[0]=2;
        console.log("Balance bob: ", bob.balance);
        console.log("Balance contract: ", address(dnft).balance); // =BUY1*0.9 + BUY2*0.9 (=45+4.5=49.5)
        //Buy 3rd time
        vm.prank(bob);
        dnft.setPrice(0, BUY3);
        vm.prank(PLAYER);

        // Test Event:
        vm.expectEmit(true,false,false,false, address(dnft)); 
        emit Winner(PLAYER); // The test pass if we have this emit with the next line
        dnft.buyToken{value: BUY3}(0); //s_buyNumberByTokenId[0]=3;

        console.log("Balance bob: ", bob.balance); // (BUY1/10) - BUY2 + (BUY3/10) (5-5+1=1)
        console.log("Balance Player: ", PLAYER.balance); // 100 - BUY1 + (BUY2/10) - BUY3 (100-50+0.5-10=40.5) + BUY1*0.9 + BUY2*0.9 + BUY3*0.9 (45+4.5+9=58.5)
        assertEq((BUY1/10) - BUY2 + (BUY3/10), bob.balance);
        assertEq(STARTING_USER_BALANCE - BUY1 + (BUY2/10) - BUY3+ (BUY1*9)/10 + (BUY2*9)/10 + (BUY3*9)/10, PLAYER.balance); //Test if he receive the funds
        
        // Test if all the things are reinisiallise:
        assertEq(0, dnft.getFundsByTokenId(0));
        assertEq(0, address(dnft).balance); //Because here we have only 1 token (just to check)
        assertEq(0, dnft.getBuyNumberByTokenId(0));
    }*/
    //////////////////////////
    // Create/Enter Raffle //
    /////////////////////////
    function testCreateRaffle() public {
        dnft.createRaffle(1 ether);
        dnft.createRaffle(10 ether);
        assertEq(1 ether, dnft.getRaffleFee(0));
        assertEq(10 ether, dnft.getRaffleFee(1));
    }
    function testEnterRaffle() public {
        dnft.createRaffle(1 ether);
        vm.prank(PLAYER);
        dnft.enterRaffle{value: 1 ether}(0);
        vm.prank(PLAYER);
        dnft.enterRaffle{value: 1 ether}(0);

        uint256[] memory raffleTokens = dnft.getRaffleIdByTokenId(0);
        assertEq(1, (raffleTokens)[0]);
        assertEq(2, (raffleTokens)[1]);
    }
    function testFailEnterNonExistentRaffle() public {
        // Attempt to enter a raffle that doesn't exist
        vm.prank(PLAYER);
        vm.expectRevert(dNFT.dNFT__RaffleNotExist.selector);
        dnft.enterRaffle{value: 1 ether}(1);
    }
    function testFailEnterRaffleWithInsufficientETH() public {
        dnft.createRaffle(1 ether);
        // Attempt to enter with less than the required ETH
        vm.prank(PLAYER);
        vm.expectRevert(dNFT.dNFT__NotEnoughETHSent.selector);
        dnft.enterRaffle{value: 0.5 ether}(0);
    }
    function testFailEnterClosedRaffle() public {
        dnft.createRaffle(1 ether);
        // Attempt to enter a closed raffle
        vm.prank(PLAYER);
        vm.expectRevert(dNFT.dNFT__RaffleNotOpen.selector);
        dnft.enterRaffle{value: 1 ether}(0);
    }
    function testEmitEnterRaffle() public 
    {
        dnft.createRaffle(1 ether);
        uint256 raffleNumber = 0;
        vm.prank(PLAYER);
        vm.expectEmit(true,true,true,false, address(dnft)); 
        emit EnteredRaffle(PLAYER, raffleNumber, 1); // The test pass if we have this emit with the next line
        dnft.enterRaffle{value: 1 ether}(raffleNumber); //bob = ID0 (a enlever plus tard); Player = ID1
    }
    function testEnterRaffleWithMultipleRaffles() public {
        // Create two raffles
        dnft.createRaffle(1 ether);
        dnft.createRaffle(2 ether);

        // Enter the first raffle
        vm.prank(PLAYER);
        dnft.enterRaffle{value: 1 ether}(0);

        // Enter the second raffle
        vm.prank(PLAYER);
        dnft.enterRaffle{value: 2 ether}(1);

        // Enter the first raffle a second time
        vm.prank(PLAYER);
        dnft.enterRaffle{value: 1 ether}(0);

        // Assertions for the first raffle
        uint256[] memory raffleTokens1 = dnft.getRaffleIdByTokenId(0);
        assertEq(1, raffleTokens1[0], "Token ID association for Raffle 1 is incorrect");
        assertEq(3, raffleTokens1[1], "Token ID association for Raffle 1 is incorrect");

        // Assertions for the second raffle
        uint256[] memory raffleTokens2 = dnft.getRaffleIdByTokenId(1);
        assertEq(2, raffleTokens2[0], "Token ID association for Raffle 2 is incorrect");
    }
    //////////////////////////////
    // PickWinner Release Funds //
    /////////////////////////////
    function testPickWinner() public {
        // Setup: Create and enter raffles
        dnft.createRaffle(50 ether);

        vm.prank(PLAYER);
        dnft.enterRaffle{value: 50 ether}(0);
        vm.prank(alice);
        dnft.enterRaffle{value: 50 ether}(0);
        vm.prank(PLAYER);
        dnft.enterRaffle{value: 50 ether}(0);

        // Close a raffle and request a random winner (The owner want to closeRaffleId = 0)
        dnft.pickWinner(0);

        // Simulation of Chainlink respond:
        uint256[] memory randomWords = new uint256[](2);
        randomWords[0] = 12882188218;
        randomWords[1] = 75175142355;
        dnft.testFulfillRandomWords(1, randomWords); // 3 tokens so 12882188218 % 3 = 1 --> alice (TokenId=2)

        assertEq(200 ether, alice.balance);
    }
    function testPickWinnerNoTokensInRaffle() public {
        dnft.createRaffle(50 ether);
        dnft.pickWinner(0);

        uint256[] memory randomWords = new uint256[](1);
        randomWords[0] = 123456789;

        vm.expectRevert(dNFT.dNFT__NoTokensInRaffle.selector);
        dnft.testFulfillRandomWords(1, randomWords);
    }
}