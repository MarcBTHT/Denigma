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
import {console} from "forge-std/Test.sol";

contract dNFT is ERC721, ERC721URIStorage, Ownable {

    error ERC721Metadata__URI_QueryFor_NonExistentToken();
    error dNFT__NotTokenOwner();
    error dNFT__TokenNotForSale();
    error dNFT__NotEnoughFunds();
    error dNFT__TransferFailed();

    uint256 private _nextTokenId;
    uint256 private s_buyNumber = 0;
    string private constant s_bonus = "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjAwIDIwMCIgd2lkdGg9IjQwMCIgIGhlaWdodD0iNDAwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogICA8Y2lyY2xlIGN4PSIxMDAiIGN5PSIxMDAiIHI9Ijc4IiBmaWxsPSJyZ2IoMjMxLDIzMiwyMDkpIiAvPgo8L3N2Zz4gCg==";
    string private constant s_malus = "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjAwIDIwMCIgd2lkdGg9IjQwMCIgIGhlaWdodD0iNDAwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogICA8Y2lyY2xlIGN4PSIxMDAiIGN5PSIxMDAiIHI9Ijc4IiBmaWxsPSJyZ2IoMTg0LDgwLDY2KSIgLz4KPC9zdmc+IA==";
    mapping(uint256 => uint256) public prices; // Mapping from token ID to the desired selling price

    event UpdatePrice(uint256 _tokenId, uint256 _price);
    event RemoveFromSale(uint256 _tokenId);
    event Purchase(address indexed buyer, address indexed seller, uint256 price);

    /** 
        * @dev Only the Owner of _tokenId must be the caller
    */
    modifier onlyTokenOwner(uint256 _tokenId) {
        if (ownerOf(_tokenId) != msg.sender) {
            revert dNFT__NotTokenOwner();
        }
        _;
    }

    constructor(address initialOwner)
        ERC721("dNFT", "DFT")
        Ownable(initialOwner)
    {}

    function MintNFT(address to) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        string memory uri = tokenURI(tokenId);
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    ///////////////////////////
    // Buy / Transfer / Sell //
    ///////////////////////////

    /**
        * @dev We add that s_buyNumber++ for each transfer
     */
    function transferFrom(address from, address to, uint256 tokenId) public override(ERC721, IERC721) {
        if (to == address(0)) {
            revert ERC721InvalidReceiver(address(0));
        }
        s_buyNumber++;
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
        approve(address(0), _tokenId); //revok the approval of the contract address (Because when no approval we have 0x0)
        emit RemoveFromSale(_tokenId);
    }
    function buyToken(uint256 _tokenId) public payable virtual { //Payable permet à la fonction de recevoir des fonds
        if (prices[_tokenId] == 0) {
            revert dNFT__TokenNotForSale();
        }
        if (msg.value < prices[_tokenId]) {
            revert dNFT__NotEnoughFunds();
        }
        address seller = ownerOf(_tokenId);
        address buyer = msg.sender;

        emit Purchase(buyer, seller, msg.value);
        IERC721(address(this)).transferFrom(seller, buyer, _tokenId); //To make the contract call the function
        (bool success, ) = payable(seller).call{value: msg.value}("");
        if (!success) {
            revert dNFT__TransferFailed();
        }
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

        if (s_buyNumber >= 1) {
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
                                Strings.toString(s_buyNumber),
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

    function getBuyNumber() public view returns (uint256) {
        return s_buyNumber;
    }
    function getPrice(uint256 _tokenId) external view returns (uint256) {
        return prices[_tokenId];
    }
}