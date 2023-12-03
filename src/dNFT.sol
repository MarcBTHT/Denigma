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

import {VRFCoordinatorV2Interface} from "lib/chainlink-brownie-contracts/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol"; //VRF
import {VRFConsumerBaseV2} from "lib/chainlink-brownie-contracts/contracts/src/v0.8/VRFConsumerBaseV2.sol"; //VRF
import {AggregatorV3Interface} from "lib/chainlink-brownie-contracts/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; //Data Feeds

// import {console} from "forge-std/Script.sol"; 

contract dNFT is ERC721, ERC721URIStorage, VRFConsumerBaseV2, Ownable {

    // ================================================================
    // |                          Errors                              |
    // ================================================================

    error dNFT__NotEnoughETHSent();
    error dNFT__RaffleNotOpen();
    error ERC721Metadata__URI_QueryFor_NonExistentToken();
    error dNFT__NotTokenOwner();
    error dNFT__TokenNotForSale();
    error dNFT__NotEnoughFunds();
    error dNFT__TransferFailed();
    error dNFT__RaffleNotExist();
    error dNFT__NoTokensInRaffle();
    error dNFT__UpkeepNotNeeded();

    // ================================================================
    // |                   Type declarations                          |
    // ================================================================

    enum RaffleState { //When we calculating winner nobody can enter
        OPEN, //0
        CLOSE //1
    }

    // ================================================================
    // |                    STATE VARIABLES                           |
    // ================================================================

    // ImageURI
    string private constant s_diamond = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4NCiAgICA8cmVjdCB4PSIyMCIgeT0iMjAiIHdpZHRoPSIzNjAiIGhlaWdodD0iMTYwIiByeD0iMjAiIHJ5PSIyMCIgZmlsbD0iIzI5ODBCOSIgLz4NCiAgICA8cGF0aCBkPSJNIDYwLDIwIGE0MCw0MCAwIDAsMCAwLDE2MCIgZmlsbD0id2hpdGUiIC8+DQogICAgPHBhdGggZD0iTSAzNDAsMjAgYTQwLDQwIDAgMCwxIDAsMTYwIiBmaWxsPSJ3aGl0ZSIgLz4NCjwvc3ZnPg==";
    string private constant s_gold = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxyZWN0IHg9IjIwIiB5PSIyMCIgd2lkdGg9IjM2MCIgaGVpZ2h0PSIxNjAiIHJ4PSIyMCIgcnk9IjIwIiBmaWxsPSJnb2xkIiAvPgogICAgPHBhdGggZD0iTSA2MCwyMCBhNDAsNDAgMCAwLDAgMCwxNjAiIGZpbGw9IndoaXRlIiAvPgogICAgPHBhdGggZD0iTSAzNDAsMjAgYTQwLDQwIDAgMCwxIDAsMTYwIiBmaWxsPSJ3aGl0ZSIgLz4KPC9zdmc+";
    string private constant s_silver = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4NCiAgICA8cmVjdCB4PSIyMCIgeT0iMjAiIHdpZHRoPSIzNjAiIGhlaWdodD0iMTYwIiByeD0iMjAiIHJ5PSIyMCIgZmlsbD0ic2lsdmVyIiAvPg0KICAgIDxwYXRoIGQ9Ik0gNjAsMjAgYTQwLDQwIDAgMCwwIDAsMTYwIiBmaWxsPSJ3aGl0ZSIgLz4NCiAgICA8cGF0aCBkPSJNIDM0MCwyMCBhNDAsNDAgMCAwLDEgMCwxNjAiIGZpbGw9IndoaXRlIiAvPg0KPC9zdmc+";
    string private constant s_bronze = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4NCiAgICA8cmVjdCB4PSIyMCIgeT0iMjAiIHdpZHRoPSIzNjAiIGhlaWdodD0iMTYwIiByeD0iMjAiIHJ5PSIyMCIgZmlsbD0iI0NEN0YzMiIgLz4NCiAgICA8cGF0aCBkPSJNIDYwLDIwIGE0MCw0MCAwIDAsMCAwLDE2MCIgZmlsbD0id2hpdGUiIC8+DQogICAgPHBhdGggZD0iTSAzNDAsMjAgYTQwLDQwIDAgMCwxIDAsMTYwIiBmaWxsPSJ3aGl0ZSIgLz4NCjwvc3ZnPg==";
    // Chainlink VRF Variables
    uint16 private constant REQUEST_CONFIRMATIONS = 3; // @dev Number of confirmations required to accept the VRF request
    uint32 private constant NUM_WORDS = 1; // @dev Number of random words to generate
    uint32 private constant CALL_BACK_GAS_LIMIT = 100000;
    uint32 private constant CALL_BACK_GAS_LIMIT_FUJI = 2490000;

    VRFCoordinatorV2Interface private immutable i_vrfCoordinator; // @dev Chainlink VRF
    uint64 private immutable i_subscriptionId; // @dev Chainlink VRF SubscriptionId
    bytes32 private immutable keyHash = 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c; //Gas fee we pay (DEPENDS ON THE NETWORK) (Here sepolia)
    bytes32 private immutable keyHashFUJI = 0x354d2f95da55398f44b7cff77da56283d9c6c829a4bdf1bbcaf2ad6a4d081f61; //Gas fee (Here fuji)
    
    // Chainlink Data Feeds Variables
    AggregatorV3Interface internal dataFeed; // @dev Chainlink Data Feed

    //Contract variables
    uint256 private _nextTokenId;
    uint256 private _nextRaffleId;
    uint256 private closeRaffleId; //When pickWinner we know wich Raffle close
    uint256 private _nextBetId;
    
    mapping(uint256 => uint256) private s_buyNumberByTokenId; //Number of buy for each token
    mapping(uint256 => uint256) public prices; // Mapping from token ID to the desired selling price
    mapping(uint256 => uint256) private fundsByRaffleId; // Tracks funds for each raffle
    mapping(uint256 => uint256) private RaffleByTokenId; // TokenId => raffle ID (For the Buy function)
    mapping(uint256 => uint256) private raffleFee; // raffle1 => fee1
    mapping(uint256 => uint256[]) private tokenIdByRaffle; //(RAFFLE1 => [TOKENID1,2,4,9...])
    mapping(uint256 => RaffleState) private raffleStates; // (Raffleid => raffleState)
    mapping(uint256 => uint256) private raffleIntervals; // (RaffleId => interval) Chainlink Automation
    mapping(uint256 => uint256) private raffleLastTimeStamp; // (RaffleId => lastTimeStamp) Chainlink Automation
    mapping(uint256 => mapping(uint256 => uint256)) private tokenScoreByRaffle; // (RaffleId => (tokenId => score))  //I need RaffleId because this way I don't need to loop on tokenIdByRaffle to take the score
    mapping(uint256 => uint256) private totalScoreByRaffle; // (RaffleId => totalScore) 
    mapping(uint256 => Bet) private bets; // _nextBetId => Bet1

    struct Bet { // For Data Feeds
        uint256 expectedPrice;
        uint256 betTime;
        uint256 settleTime;
        uint256[] participantTokenIdList;
        mapping(uint256 => bool) participantBets;  // TokenId => bool
        RaffleState BetState;
    }

    // ================================================================
    // |                          Events                              |
    // ================================================================

    event EnteredRaffle(address indexed player, uint256 raffleNumber, uint256 tokenId);
    event UpdatePrice(uint256 _tokenId, uint256 _price);
    event RemoveFromSale(uint256 _tokenId);
    event Purchase(address indexed buyer, address indexed seller, uint256 price);
    event Winner(address indexed winner, uint256 winningTokenId, uint256 amount);
    event RandomNum(uint256 randomNum);
    event CreatedRaffle(uint256 raffleId, uint256 entranceFee, uint256 interval);
    event UpdatedScore(uint256 raffleId, uint256 tokenId, uint256 score);
    event CreatedBet(uint256 expectedPrice, uint256 settleTime);
    event EnteredBet(address indexed player, uint256 BetId, uint256 tokenId, bool betChoice);

    // ================================================================
    // |                          Modifiers                           |
    // ================================================================

    /** 
        * @dev Only the Owner of _tokenId must be the caller
    */
    modifier onlyTokenOwner(uint256 _tokenId) {
        if (ownerOf(_tokenId) != msg.sender) {
            revert dNFT__NotTokenOwner();
        }
        _;
    }

    // ================================================================
    // |                          Functions                           |
    // ================================================================

    constructor(address initialOwner, address vrfCoordinator, uint64 subscriptionId, address dataFeedAdress)
        ERC721("dNFT", "DFT")
        VRFConsumerBaseV2(vrfCoordinator)
        Ownable(initialOwner) {
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinator);
        i_subscriptionId = subscriptionId;    
        dataFeed = AggregatorV3Interface(dataFeedAdress); 
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
    function createRaffle(uint256 entranceFee, uint256 interval) external onlyOwner {
        uint256 raffleId = _nextRaffleId++;
        raffleFee[raffleId] = entranceFee;
        raffleStates[raffleId] = RaffleState.OPEN; 
        raffleIntervals[raffleId] = interval; // Set the duration of the raffle
        raffleLastTimeStamp[raffleId] = block.timestamp; // Set the last timestamp of the raffle
        emit CreatedRaffle(raffleId, entranceFee, interval);
    }
    function enterRaffle(uint256 RaffleNumber) external payable {
        if (RaffleNumber > _nextRaffleId-1) {
            revert dNFT__RaffleNotExist();
        }
        if (msg.value < raffleFee[RaffleNumber]) {
            revert dNFT__NotEnoughETHSent();
        }
        if (raffleStates[RaffleNumber] != RaffleState.OPEN) { 
            revert dNFT__RaffleNotOpen();
        }
        uint256 tempTokenId = _nextTokenId;
        _mintNFT(msg.sender); //Mint a NFT for the player 
        tokenIdByRaffle[RaffleNumber].push(tempTokenId); // ADD the tokenId to the associated raffle
        RaffleByTokenId[tempTokenId] = RaffleNumber; // Associate the token with the raffle
        
        updateScore(RaffleNumber, tempTokenId, 1);// Starting score for the evolution of the NFT
        
        fundsByRaffleId[RaffleNumber] += msg.value;// Add entrance fee to raffle's funds
        emit EnteredRaffle(msg.sender, RaffleNumber, tempTokenId);
    }

    // ================================================================
    // |             Functions to Buy and Sell token                  |
    // ================================================================

    /**
        * @dev We increase s_buyNumberByTokenId[tokenId] and check if it is equal to s_randomNumber
     */
    function transferFrom(address from, address to, uint256 tokenId) public override(ERC721, IERC721) {
        if (to == address(0)) {
            revert ERC721InvalidReceiver(address(0));
        }
        delete prices[tokenId];
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
        uint256 raffleId = RaffleByTokenId[_tokenId]; // Find the associated raffle
        if (raffleStates[raffleId] == RaffleState.CLOSE) {
            revert dNFT__RaffleNotOpen();
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

        fundsByRaffleId[raffleId] += raffleShare; // transfer raffle's share
        emit Purchase(buyer, seller, msg.value);

        UpdateBuyScore(raffleId, _tokenId); // Update the score of the NFT 

        IERC721(address(this)).transferFrom(seller, buyer, _tokenId); //To make the contract call the function
    }
    // ================================================================
    // |                        Update dNFT                           |
    // ================================================================
    /**
     * @dev This is the function update the state of the NFT. It's call in the other functions (when Buying a NFT, when succeed a quest, ...)
     */
    function updateScore(uint256 raffleId, uint256 tokenId, uint256 score) internal {
        if (raffleStates[raffleId] != RaffleState.OPEN) { 
            revert dNFT__RaffleNotOpen();
        }
        emit UpdatedScore(raffleId,tokenId,score);
        tokenScoreByRaffle[raffleId][tokenId] += score; 
        totalScoreByRaffle[raffleId] += score;
    }
    // ====================================BUYING PART==========================================
    /**
     * @dev When a player buy a NFT we update the score of the NFT (dNFT)
     */
    function UpdateBuyScore(uint256 raffleId, uint256 tokenId) internal {
        s_buyNumberByTokenId[tokenId]++;
        if (s_buyNumberByTokenId[tokenId] % 3 == 0) { // Need to modify to be the most fair possible
            updateScore(raffleId, tokenId, 1); // Increment the score by 1 for every 3 buys
        }
    }
    // =====================================BET PART=============================================
    /**
     * @dev The Owner can create a bet on the price of BTC. And set the horizon time for the bet.
     */
    function createBet(uint256 _expectedPrice, uint256 _settleTime) external onlyOwner {
        Bet storage newBet = bets[_nextBetId];
        newBet.expectedPrice = _expectedPrice;
        newBet.betTime = block.timestamp;
        newBet.settleTime = block.timestamp + _settleTime;
        newBet.BetState = RaffleState.OPEN;
        _nextBetId++;
        emit CreatedBet(_expectedPrice, _settleTime);
    }
    function placeBet(uint256 betId, uint256 tokenId, bool betChoice) external onlyTokenOwner(tokenId) {
        require(bets[betId].BetState == RaffleState.OPEN, "Bet is not open.");
        bets[betId].participantBets[tokenId] = betChoice;
        bets[betId].participantTokenIdList.push(tokenId);
        emit EnteredBet(msg.sender, betId, tokenId, betChoice);
    }
    function updateBetScore(uint256 betId) public { //Call by chainlink AUTOMATION (I do timebase for know but I need to do Custom Logic but already have one so...)
        Bet storage bet = bets[betId];
        require(bets[betId].BetState == RaffleState.OPEN, "Bet is not open.");
        require(block.timestamp >= bet.settleTime, "Bet settle time has not been reached.");
        bet.BetState = RaffleState.CLOSE; // Close the bet
        int currentPrice = getChainlinkDataFeedLatestAnswer();
        //int currentPrice = 3873828375545; // WHEN TESTING
        bool result = uint256(currentPrice) >= bet.expectedPrice;

        // Process the result for each participant
        for (uint i = 0; i < bet.participantTokenIdList.length; i++) {
            uint256 tokenId = bet.participantTokenIdList[i];
            bool didWin = bet.participantBets[tokenId] == result;
            if (didWin) {
                updateScore(RaffleByTokenId[tokenId], tokenId, 1); // Increment the score by 1 if they won
            }
        }
    }
    // =======================================ENIGMA PART===========================================

    // ================================================================
    // |                   CHAINLINK AUTOMATION                       |
    // ================================================================

    /**
     * @dev This is the function that the Chainlink Keeper nodes call
     * they look for `upkeepNeeded` to return True. (CUSTOM LOGIC)
    */
    function checkUpkeep(
        bytes memory /* checkData */
    ) public returns (bool upkeepNeeded, bytes memory /* performData */) {
        for (uint256 raffle_Id = 0; raffle_Id < _nextRaffleId; raffle_Id++) { // Loop through all raffles to see if one is ready to be closed
            bool timeHasPassed = (block.timestamp - raffleLastTimeStamp[raffle_Id]) >= raffleIntervals[raffle_Id];
            bool isOpen = RaffleState.OPEN == raffleStates[raffle_Id];
            bool hasPlayers = tokenIdByRaffle[raffle_Id].length > 0;
            if (timeHasPassed && isOpen && hasPlayers ) {
                closeRaffleId = raffle_Id;
                return (true, "0x0");
            }
        }
        return (false, "0x0");
    }
    function performUpkeep(bytes calldata /* performData */) external {
        (bool upkeepNeeded,) = checkUpkeep("");
        if (!upkeepNeeded) {
            revert dNFT__UpkeepNotNeeded();
        }
        raffleStates[closeRaffleId] = RaffleState.CLOSE;
        /** GET THE FOLLOWING OFF WHEN TESTING (Until I did a config for anvil)*/
        i_vrfCoordinator.requestRandomWords( //On fait la requete pour avoir nombre random ! Après chainlink appel fulfillRandomWords
            keyHashFUJI, 
            i_subscriptionId,
            REQUEST_CONFIRMATIONS,
            CALL_BACK_GAS_LIMIT_FUJI,
            NUM_WORDS
        );
    }
    /** Just for the test to call fulfillRandomWords because it's internal ! */
    function testFulfillRandomWords(uint256 requestId, uint256[] memory randomWords) public { 
        fulfillRandomWords(requestId, randomWords);
    }
    // ================================================================
    // |                        CHAINLINK VRF                         |
    // ================================================================
    function fulfillRandomWords( //C'est la fonction que chainlink appel, elle donne en paramètre le nombre random que l'on veut !! Après on fait ce que l'on en veut !!!
        uint256 /*requestId*/,
        uint256[] memory randomWords
    ) internal override {
        uint256[] memory tokensInRaffle = tokenIdByRaffle[closeRaffleId];
        uint256 totalTokens = tokensInRaffle.length;
        if (totalTokens == 0) {
            revert dNFT__NoTokensInRaffle();
        }
        uint256 totalWeight = totalScoreByRaffle[closeRaffleId]; //Each Token Have a score : Token1=1, Token2=3, Token3=2 => totalWeight = 6
        uint256 weightedRandomIndex = randomWords[0] % totalWeight; //Give a random number between 0 and totalWeight => For exemple 2
        uint256 runningTotal = 0;
        uint256 winningTokenId = 0; // Temporary variable to store the winning token ID

        for (uint256 i = 0; i < totalTokens; i++) { //We fo through all the tokens in the raffle (In order, I think to randomize more we can shuffle the list before)
            uint256 tokenId = tokensInRaffle[i]; // Loop1: TolenId1 // Loop2: TokenId2
            runningTotal += tokenScoreByRaffle[closeRaffleId][tokenId]; // Loop1: 0+1=1 // Loop2: 1+3=4 or 2 < 4 => Winning TokenId = TokenId2
            if (weightedRandomIndex < runningTotal) { //< or <= ?? Need to see
                winningTokenId = tokenId; // Return the winning token ID
                break;
            }
        }
        emit RandomNum(randomWords[0]);
        address winner = ownerOf(winningTokenId);

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
    }
    // ================================================================
    // |                   CHAINLINK DATA FEEDS                       |
    // ================================================================
    function getChainlinkDataFeedLatestAnswer() public view returns (int) {
        (
            /* uint80 roundID */,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return price;
    }
    // ================================================================
    // |                          METADATA                            |
    // ================================================================
    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        string memory imageURI = s_bronze;
        uint256 tokenScore = tokenScoreByRaffle[RaffleByTokenId[tokenId]][tokenId];

        if (tokenScore > 5) {
            imageURI = s_diamond;
        } else if (tokenScore > 3) {
            imageURI = s_gold;
        } else if (tokenScore > 1) {
            imageURI = s_silver;
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
                                '", "score":"',
                                Strings.toString(tokenScore),
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
    function getfundsByRaffleId(uint256 _raffleId) external view returns (uint256) {
        return fundsByRaffleId[_raffleId];
    }
    function getLastTimeStamp(uint256 _raffleId) external view returns (uint256) {
        return raffleLastTimeStamp[_raffleId];
    }
    function getTokenScoreByRaffle(uint256 raffleId, uint256 tokenId) public view returns (uint256) {
        return tokenScoreByRaffle[raffleId][tokenId];
    }
    function getRaffleState(uint256 raffleId) external view returns (RaffleState) {
        return raffleStates[raffleId];
    }
    struct ReturnBet { //I need that because I can't return a mapping
        uint256 expectedPrice;
        uint256 betTime;
        uint256 settleTime;
        uint256[] participantTokenIdList;
        RaffleState BetState;
    }
    function getBets(uint256 betId) public view returns (ReturnBet memory) {
        Bet storage bet = bets[betId];
        return ReturnBet(
            bet.expectedPrice,
            bet.betTime,
            bet.settleTime,
            bet.participantTokenIdList,
            bet.BetState
        );
    }
    function getParticipantBet(uint256 betId, uint256 tokenId) public view returns (bool) { //To return the mapping of the struct
        return bets[betId].participantBets[tokenId];
    }
}