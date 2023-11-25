// Layout of Contract:
    // version
    // imports
    // errors
    // interfaces, libraries, contracts
    // Type declarations
    // State variables
    // Events
    // Modifiers
    // Functions

// Layout of Functions:
    // constructor
    // receive function (if exists)
    // fallback function (if exists)
    // external
    // public
    // internal
    // private
    // view & pure functions

// SPDX-Licence-Identifier: MIT


pragma solidity ^0.8.19;

import "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import "lib/openzeppelin-contracts/contracts/utils/Base64.sol";
import "lib/openzeppelin-contracts/contracts/utils/Strings.sol";

import {VRFCoordinatorV2Interface} from "lib/chainlink-brownie-contracts/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import {VRFConsumerBaseV2} from "lib/chainlink-brownie-contracts/contracts/src/v0.8/VRFConsumerBaseV2.sol";

import {console} from "forge-std/Script.sol"; 

contract dNFT is ERC721, ERC721URIStorage, VRFConsumerBaseV2, Ownable {

    error dNFT__NotEnoughETHSent();
    error dNFT__RaffleNotOpen();
    error ERC721Metadata__URI_QueryFor_NonExistentToken();
    error dNFT__NotTokenOwner();
    error dNFT__TokenNotForSale();
    error dNFT__NotEnoughFunds();
    error dNFT__TransferFailed();
    error dNFT__RaffleNotExist();
    error dNFT__NoTokensInRaffle();

    enum RaffleState { //When we calculating winner nobody can enter
        OPEN, //0
        CALCULATING //1
    }

    string private constant s_bonus = "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjAwIDIwMCIgd2lkdGg9IjQwMCIgIGhlaWdodD0iNDAwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogICA8Y2lyY2xlIGN4PSIxMDAiIGN5PSIxMDAiIHI9Ijc4IiBmaWxsPSJyZ2IoMjMxLDIzMiwyMDkpIiAvPgo8L3N2Zz4gCg==";
    string private constant s_malus = "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjAwIDIwMCIgd2lkdGg9IjQwMCIgIGhlaWdodD0iNDAwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogICA8Y2lyY2xlIGN4PSIxMDAiIGN5PSIxMDAiIHI9Ijc4IiBmaWxsPSJyZ2IoMTg0LDgwLDY2KSIgLz4KPC9zdmc+IA==";
    /**
        @dev All the variables to manage the VRF:
    */
    uint16 private constant REQUEST_CONFIRMATIONS = 3; // @dev Number of confirmations required to accept the VRF request
    uint32 private constant NUM_WORDS = 1; // @dev Number of random words to generate
    uint32 private constant CALL_BACK_GAS_LIMIT = 100000;
    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
    uint64 private immutable i_subscriptionId;
    bytes32 private keyHash = 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c; //Gas fee we pay (DEPENDS ON THE NETWORK) (Here sepolia)
    
    uint256 private immutable i_entranceFee;
    uint256 private _nextTokenId;
    uint256 private _nextRaffleId;
    uint256 private closeRaffleId; //When pickWinner we know wich Raffle close
    mapping(uint256 => uint256) private s_buyNumberByTokenId; //Number of buy for each token
    mapping(uint256 => uint256) public prices; // Mapping from token ID to the desired selling price
    mapping(uint256 => uint256) private fundsByRaffleId; // Tracks funds for each raffle
    mapping(uint256 => uint256) private RaffleByTokenId; // TokenId => raffle ID (For the Buy function)
    mapping(uint256 => uint256) private raffleFee; // raffle1 => fee1
    mapping(uint256 => uint256[]) private tokenIdByRaffle; //(RAFFLE1 => [TOKENID1,2,4,9...])
    RaffleState private s_raffleState; //WE NEED TO DO A MAPPING (Raffleid => raffleState)

    event EnteredRaffle(address indexed player, uint256 raffleNumber, uint256 tokenId);
    event UpdatePrice(uint256 _tokenId, uint256 _price);
    event RemoveFromSale(uint256 _tokenId);
    event Purchase(address indexed buyer, address indexed seller, uint256 price);
    event Winner(address indexed winner, uint256 winningTokenId, uint256 amount);

    /** 
        * @dev Only the Owner of _tokenId must be the caller
    */
    modifier onlyTokenOwner(uint256 _tokenId) {
        if (ownerOf(_tokenId) != msg.sender) {
            revert dNFT__NotTokenOwner();
        }
        _;
    }
    constructor(address initialOwner, address vrfCoordinator, uint64 subscriptionId)
        ERC721("dNFT", "DFT")
        VRFConsumerBaseV2(vrfCoordinator)
        Ownable(initialOwner) {
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinator);
        i_subscriptionId = subscriptionId;    
        s_raffleState = RaffleState.OPEN;
    }
    function _mintNFT(address to) internal {
        uint256 tokenId = _nextTokenId++;
        string memory uri = tokenURI(tokenId);
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }
    function MintNFT(address to) public onlyOwner { //Because I need to change all my test (To only mint when enter a raffle)
        _mintNFT(to);
    }
    function createRaffle(uint256 entranceFee) external onlyOwner {
        uint256 raffleId = _nextRaffleId++;
        raffleFee[raffleId] = entranceFee;
    }
    function enterRaffle(uint256 RaffleNumber) external payable {
        if (RaffleNumber > _nextRaffleId-1) {
            revert dNFT__RaffleNotExist();
        }
        if (msg.value < i_entranceFee) {
            revert dNFT__NotEnoughETHSent();
        }
        if (s_raffleState != RaffleState.OPEN) { 
            revert dNFT__RaffleNotOpen();
        }
        uint256 tempTokenId = _nextTokenId;
        _mintNFT(msg.sender); //Mint a NFT for the player 
        tokenIdByRaffle[RaffleNumber].push(tempTokenId); // ADD the tokenId to the associated raffle
        RaffleByTokenId[tempTokenId] = RaffleNumber; // Associate the token with the raffle
        fundsByRaffleId[RaffleNumber] += msg.value;// Add entrance fee to raffle's funds
        emit EnteredRaffle(msg.sender, RaffleNumber, tempTokenId);
    }

    ///////////////////////////
    // Buy / Transfer / Sell //
    ///////////////////////////

    /**
        * @dev We increase s_buyNumberByTokenId[tokenId] and check if it is equal to s_randomNumber
     */
    function transferFrom(address from, address to, uint256 tokenId) public override(ERC721, IERC721) {
        if (to == address(0)) {
            revert ERC721InvalidReceiver(address(0));
        }
        s_buyNumberByTokenId[tokenId]++; // !!!WE NEED TO DO THAT ONLY IF IT'S THE CONTRACT THAT CALL TRANSFERFROM!!!  TO DO !!!!
        delete prices[tokenId];
        /** WE Don't anymore do that. The more tranfer you did the more you have chance to win. But we pick the winner only at the end of the Enigma.
        if (s_buyNumberByTokenId[tokenId] == s_randomNumber) {
            releaseFunds(to, tokenId); // Release funds to the new owner before transfer
        } */
        return super.transferFrom(from,to,tokenId);
    }
    
    function setPrice(uint256 _tokenId, uint256 _price)
        external
        virtual
        onlyTokenOwner(_tokenId)
    {
        prices[_tokenId] = _price; //Price in ETH
        approve(address(this), _tokenId); //Approve the contract address to transfer this token
        emit UpdatePrice(_tokenId, _price);
    }
    function removeTokenSale(uint256 _tokenId)
        external
        virtual
        onlyTokenOwner(_tokenId)
    {
        delete prices[_tokenId];
        approve(address(0), _tokenId); //revoke the approval of the contract address (Because when no approval we have 0x0)
        emit RemoveFromSale(_tokenId);
    }
    function buyToken(uint256 _tokenId) public payable virtual { //Payable allows the function to receive ETH, is automatically added to the balance of the contract
        if (prices[_tokenId] == 0) {
            revert dNFT__TokenNotForSale();
        }
        if (msg.value < prices[_tokenId]) {
            revert dNFT__NotEnoughFunds();
        }
        address seller = ownerOf(_tokenId);
        address buyer = msg.sender;
        // Calculate the split
        uint256 sellerShare = msg.value / 10; // 10% to the seller
        uint256 raffleShare = msg.value - sellerShare; // 90% to the contract

        (bool success, ) = payable(seller).call{value: sellerShare}("");
        if (!success) {
            revert dNFT__TransferFailed();
        }

        // Find the associated raffle and transfer raffle's share
        uint256 raffleId = RaffleByTokenId[_tokenId];
        fundsByRaffleId[raffleId] += raffleShare;

        emit Purchase(buyer, seller, msg.value);

        IERC721(address(this)).transferFrom(seller, buyer, _tokenId); //To make the contract call the function
    }
    function pickWinner(uint256 _closeRaffleId) external onlyOwner {
        //METTRE DES CONDITIONS When Automation//
        closeRaffleId = _closeRaffleId;
        s_raffleState = RaffleState.CALCULATING;
        // Get a Random winner
        /** GET THE FOLLOWING OFF WHEN TESTING (Until I did a config for anvil) */
        i_vrfCoordinator.requestRandomWords( //On fait la requete pour avoir nombre random ! Après chainlink appel fulfillRandomWords
            keyHash, 
            i_subscriptionId,
            REQUEST_CONFIRMATIONS,
            CALL_BACK_GAS_LIMIT,
            NUM_WORDS
        );
    }
    /** Just for the test to call fulfillRandomWords because it's internal ! */
    function testFulfillRandomWords(uint256 requestId, uint256[] memory randomWords) public { 
        fulfillRandomWords(requestId, randomWords);
    }
    function fulfillRandomWords( //C'est la fonction que chainlink appel, elle donne en paramètre le nombre random que l'on veut !! Après on fait ce que l'on en veut !!!
        uint256 /*requestId*/,
        uint256[] memory randomWords
    ) internal override {
        uint256[] memory tokensInRaffle = tokenIdByRaffle[closeRaffleId];
        uint256 totalTokens = tokensInRaffle.length;

        if (totalTokens == 0) {
            revert dNFT__NoTokensInRaffle();
        }
        uint256 indexOfWinner = randomWords[0] % totalTokens;
        uint256 winningTokenId = tokensInRaffle[indexOfWinner];
        address winner = ownerOf(winningTokenId);

        console.log("randomNumber: ", randomWords[0]);
        console.log("totalTokens: ", totalTokens);
        console.log("indexOfWinner: ", indexOfWinner);

        //Release Funds:
        uint256 amount = fundsByRaffleId[closeRaffleId];
        if (amount == 0) {
            revert dNFT__NotEnoughFunds();
        }
        emit Winner(winner, winningTokenId, amount);
        (bool success, ) = payable(winner).call{value: amount}("");
        if (!success) {
            revert dNFT__TransferFailed();
        }
        fundsByRaffleId[closeRaffleId] = 0;

        s_raffleState = RaffleState.OPEN;
    }

    //////////////////
    //Write METADATA//
    //////////////////
    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        string memory imageURI = s_bonus;

        if (s_buyNumberByTokenId[tokenId] >= 1) { // !!TEMPORARY!! Just to test for the moment 
            imageURI = s_malus;
        }
        return 
           string(
            abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name(), 
                                '", "BuyNumber":"',
                                Strings.toString(s_buyNumberByTokenId[tokenId]),
                                '", "image":"',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
        );
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function getBuyNumberByTokenId(uint256 tokenId) external view returns (uint256) {
        return s_buyNumberByTokenId[tokenId];
    }
    function getPrice(uint256 _tokenId) external view returns (uint256) {
        return prices[_tokenId];
    }
    function getRaffleFee(uint256 _raffleId) external view returns (uint256) {
        return raffleFee[_raffleId];
    }
    function getRaffleIdByTokenId(uint256 _raffleId) external view returns (uint256[] memory) {
        return tokenIdByRaffle[_raffleId];
    }
}