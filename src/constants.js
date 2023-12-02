export const contractAddress = "0xD92af16Bffd77937cf765831CABf067f7c45D371";
export const abi = [
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "initialOwner",
        "type": "address"
      },
      {
        "internalType": "address",
        "name": "vrfCoordinator",
        "type": "address"
      },
      {
        "internalType": "uint64",
        "name": "subscriptionId",
        "type": "uint64"
      },
      {
        "internalType": "address",
        "name": "dataFeedAdress",
        "type": "address"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "constructor"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "sender",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      },
      {
        "internalType": "address",
        "name": "owner",
        "type": "address"
      }
    ],
    "name": "ERC721IncorrectOwner",
    "type": "error"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "operator",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "name": "ERC721InsufficientApproval",
    "type": "error"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "approver",
        "type": "address"
      }
    ],
    "name": "ERC721InvalidApprover",
    "type": "error"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "operator",
        "type": "address"
      }
    ],
    "name": "ERC721InvalidOperator",
    "type": "error"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "owner",
        "type": "address"
      }
    ],
    "name": "ERC721InvalidOwner",
    "type": "error"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "receiver",
        "type": "address"
      }
    ],
    "name": "ERC721InvalidReceiver",
    "type": "error"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "sender",
        "type": "address"
      }
    ],
    "name": "ERC721InvalidSender",
    "type": "error"
  },
  {
    "inputs": [],
    "name": "ERC721Metadata__URI_QueryFor_NonExistentToken",
    "type": "error"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "name": "ERC721NonexistentToken",
    "type": "error"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "have",
        "type": "address"
      },
      {
        "internalType": "address",
        "name": "want",
        "type": "address"
      }
    ],
    "name": "OnlyCoordinatorCanFulfill",
    "type": "error"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "owner",
        "type": "address"
      }
    ],
    "name": "OwnableInvalidOwner",
    "type": "error"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "account",
        "type": "address"
      }
    ],
    "name": "OwnableUnauthorizedAccount",
    "type": "error"
  },
  {
    "inputs": [],
    "name": "dNFT__NoTokensInRaffle",
    "type": "error"
  },
  {
    "inputs": [],
    "name": "dNFT__NotEnoughETHSent",
    "type": "error"
  },
  {
    "inputs": [],
    "name": "dNFT__NotEnoughFunds",
    "type": "error"
  },
  {
    "inputs": [],
    "name": "dNFT__NotTokenOwner",
    "type": "error"
  },
  {
    "inputs": [],
    "name": "dNFT__RaffleNotExist",
    "type": "error"
  },
  {
    "inputs": [],
    "name": "dNFT__RaffleNotOpen",
    "type": "error"
  },
  {
    "inputs": [],
    "name": "dNFT__TokenNotForSale",
    "type": "error"
  },
  {
    "inputs": [],
    "name": "dNFT__TransferFailed",
    "type": "error"
  },
  {
    "inputs": [],
    "name": "dNFT__UpkeepNotNeeded",
    "type": "error"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": true,
        "internalType": "address",
        "name": "owner",
        "type": "address"
      },
      {
        "indexed": true,
        "internalType": "address",
        "name": "approved",
        "type": "address"
      },
      {
        "indexed": true,
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "name": "Approval",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": true,
        "internalType": "address",
        "name": "owner",
        "type": "address"
      },
      {
        "indexed": true,
        "internalType": "address",
        "name": "operator",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "bool",
        "name": "approved",
        "type": "bool"
      }
    ],
    "name": "ApprovalForAll",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_fromTokenId",
        "type": "uint256"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_toTokenId",
        "type": "uint256"
      }
    ],
    "name": "BatchMetadataUpdate",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "expectedPrice",
        "type": "uint256"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "settleTime",
        "type": "uint256"
      }
    ],
    "name": "CreatedBet",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "raffleId",
        "type": "uint256"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "entranceFee",
        "type": "uint256"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "interval",
        "type": "uint256"
      }
    ],
    "name": "CreatedRaffle",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": true,
        "internalType": "address",
        "name": "player",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "BetId",
        "type": "uint256"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      },
      {
        "indexed": false,
        "internalType": "bool",
        "name": "betChoice",
        "type": "bool"
      }
    ],
    "name": "EnteredBet",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": true,
        "internalType": "address",
        "name": "player",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "raffleNumber",
        "type": "uint256"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "name": "EnteredRaffle",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_tokenId",
        "type": "uint256"
      }
    ],
    "name": "MetadataUpdate",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": true,
        "internalType": "address",
        "name": "previousOwner",
        "type": "address"
      },
      {
        "indexed": true,
        "internalType": "address",
        "name": "newOwner",
        "type": "address"
      }
    ],
    "name": "OwnershipTransferred",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": true,
        "internalType": "address",
        "name": "buyer",
        "type": "address"
      },
      {
        "indexed": true,
        "internalType": "address",
        "name": "seller",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "price",
        "type": "uint256"
      }
    ],
    "name": "Purchase",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "randomNum",
        "type": "uint256"
      }
    ],
    "name": "RandomNum",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_tokenId",
        "type": "uint256"
      }
    ],
    "name": "RemoveFromSale",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": true,
        "internalType": "address",
        "name": "from",
        "type": "address"
      },
      {
        "indexed": true,
        "internalType": "address",
        "name": "to",
        "type": "address"
      },
      {
        "indexed": true,
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "name": "Transfer",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_tokenId",
        "type": "uint256"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_price",
        "type": "uint256"
      }
    ],
    "name": "UpdatePrice",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "raffleId",
        "type": "uint256"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "score",
        "type": "uint256"
      }
    ],
    "name": "UpdatedScore",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": true,
        "internalType": "address",
        "name": "winner",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "winningTokenId",
        "type": "uint256"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "amount",
        "type": "uint256"
      }
    ],
    "name": "Winner",
    "type": "event"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "to",
        "type": "address"
      }
    ],
    "name": "MintNFT",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "to",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "name": "approve",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "owner",
        "type": "address"
      }
    ],
    "name": "balanceOf",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_tokenId",
        "type": "uint256"
      }
    ],
    "name": "buyToken",
    "outputs": [],
    "stateMutability": "payable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "bytes",
        "name": "",
        "type": "bytes"
      }
    ],
    "name": "checkUpkeep",
    "outputs": [
      {
        "internalType": "bool",
        "name": "upkeepNeeded",
        "type": "bool"
      },
      {
        "internalType": "bytes",
        "name": "",
        "type": "bytes"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_expectedPrice",
        "type": "uint256"
      },
      {
        "internalType": "uint256",
        "name": "_settleTime",
        "type": "uint256"
      }
    ],
    "name": "createBet",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "entranceFee",
        "type": "uint256"
      },
      {
        "internalType": "uint256",
        "name": "interval",
        "type": "uint256"
      }
    ],
    "name": "createRaffle",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "RaffleNumber",
        "type": "uint256"
      }
    ],
    "name": "enterRaffle",
    "outputs": [],
    "stateMutability": "payable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "name": "getApproved",
    "outputs": [
      {
        "internalType": "address",
        "name": "",
        "type": "address"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "betId",
        "type": "uint256"
      }
    ],
    "name": "getBets",
    "outputs": [
      {
        "components": [
          {
            "internalType": "uint256",
            "name": "expectedPrice",
            "type": "uint256"
          },
          {
            "internalType": "uint256",
            "name": "betTime",
            "type": "uint256"
          },
          {
            "internalType": "uint256",
            "name": "settleTime",
            "type": "uint256"
          },
          {
            "internalType": "uint256[]",
            "name": "participantTokenIdList",
            "type": "uint256[]"
          },
          {
            "internalType": "enum dNFT.RaffleState",
            "name": "BetState",
            "type": "uint8"
          }
        ],
        "internalType": "struct dNFT.ReturnBet",
        "name": "",
        "type": "tuple"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "name": "getBuyNumberByTokenId",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "getChainlinkDataFeedLatestAnswer",
    "outputs": [
      {
        "internalType": "int256",
        "name": "",
        "type": "int256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_raffleId",
        "type": "uint256"
      }
    ],
    "name": "getLastTimeStamp",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "betId",
        "type": "uint256"
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "name": "getParticipantBet",
    "outputs": [
      {
        "internalType": "bool",
        "name": "",
        "type": "bool"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_tokenId",
        "type": "uint256"
      }
    ],
    "name": "getPrice",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_raffleId",
        "type": "uint256"
      }
    ],
    "name": "getRaffleFee",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_raffleId",
        "type": "uint256"
      }
    ],
    "name": "getRaffleIdByTokenId",
    "outputs": [
      {
        "internalType": "uint256[]",
        "name": "",
        "type": "uint256[]"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "raffleId",
        "type": "uint256"
      }
    ],
    "name": "getRaffleState",
    "outputs": [
      {
        "internalType": "enum dNFT.RaffleState",
        "name": "",
        "type": "uint8"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "raffleId",
        "type": "uint256"
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "name": "getTokenScoreByRaffle",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_raffleId",
        "type": "uint256"
      }
    ],
    "name": "getfundsByRaffleId",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "owner",
        "type": "address"
      },
      {
        "internalType": "address",
        "name": "operator",
        "type": "address"
      }
    ],
    "name": "isApprovedForAll",
    "outputs": [
      {
        "internalType": "bool",
        "name": "",
        "type": "bool"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "name",
    "outputs": [
      {
        "internalType": "string",
        "name": "",
        "type": "string"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "owner",
    "outputs": [
      {
        "internalType": "address",
        "name": "",
        "type": "address"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "name": "ownerOf",
    "outputs": [
      {
        "internalType": "address",
        "name": "",
        "type": "address"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "bytes",
        "name": "",
        "type": "bytes"
      }
    ],
    "name": "performUpkeep",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "betId",
        "type": "uint256"
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      },
      {
        "internalType": "bool",
        "name": "betChoice",
        "type": "bool"
      }
    ],
    "name": "placeBet",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "name": "prices",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "requestId",
        "type": "uint256"
      },
      {
        "internalType": "uint256[]",
        "name": "randomWords",
        "type": "uint256[]"
      }
    ],
    "name": "rawFulfillRandomWords",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_tokenId",
        "type": "uint256"
      }
    ],
    "name": "removeTokenSale",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "renounceOwnership",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "from",
        "type": "address"
      },
      {
        "internalType": "address",
        "name": "to",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "name": "safeTransferFrom",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "from",
        "type": "address"
      },
      {
        "internalType": "address",
        "name": "to",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      },
      {
        "internalType": "bytes",
        "name": "data",
        "type": "bytes"
      }
    ],
    "name": "safeTransferFrom",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "operator",
        "type": "address"
      },
      {
        "internalType": "bool",
        "name": "approved",
        "type": "bool"
      }
    ],
    "name": "setApprovalForAll",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_tokenId",
        "type": "uint256"
      },
      {
        "internalType": "uint256",
        "name": "_price",
        "type": "uint256"
      }
    ],
    "name": "setPrice",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "bytes4",
        "name": "interfaceId",
        "type": "bytes4"
      }
    ],
    "name": "supportsInterface",
    "outputs": [
      {
        "internalType": "bool",
        "name": "",
        "type": "bool"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "symbol",
    "outputs": [
      {
        "internalType": "string",
        "name": "",
        "type": "string"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "requestId",
        "type": "uint256"
      },
      {
        "internalType": "uint256[]",
        "name": "randomWords",
        "type": "uint256[]"
      }
    ],
    "name": "testFulfillRandomWords",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "name": "tokenURI",
    "outputs": [
      {
        "internalType": "string",
        "name": "",
        "type": "string"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "from",
        "type": "address"
      },
      {
        "internalType": "address",
        "name": "to",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "name": "transferFrom",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "newOwner",
        "type": "address"
      }
    ],
    "name": "transferOwnership",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "betId",
        "type": "uint256"
      }
    ],
    "name": "updateBetScore",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "initialOwner",
        "type": "address"
      },
      {
        "internalType": "address",
        "name": "vrfCoordinator",
        "type": "address"
      },
      {
        "internalType": "uint64",
        "name": "subscriptionId",
        "type": "uint64"
      },
      {
        "internalType": "address",
        "name": "dataFeedAdress",
        "type": "address"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "constructor"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "sender",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      },
      {
        "internalType": "address",
        "name": "owner",
        "type": "address"
      }
    ],
    "type": "error",
    "name": "ERC721IncorrectOwner"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "operator",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "type": "error",
    "name": "ERC721InsufficientApproval"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "approver",
        "type": "address"
      }
    ],
    "type": "error",
    "name": "ERC721InvalidApprover"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "operator",
        "type": "address"
      }
    ],
    "type": "error",
    "name": "ERC721InvalidOperator"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "owner",
        "type": "address"
      }
    ],
    "type": "error",
    "name": "ERC721InvalidOwner"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "receiver",
        "type": "address"
      }
    ],
    "type": "error",
    "name": "ERC721InvalidReceiver"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "sender",
        "type": "address"
      }
    ],
    "type": "error",
    "name": "ERC721InvalidSender"
  },
  {
    "inputs": [],
    "type": "error",
    "name": "ERC721Metadata__URI_QueryFor_NonExistentToken"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "type": "error",
    "name": "ERC721NonexistentToken"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "have",
        "type": "address"
      },
      {
        "internalType": "address",
        "name": "want",
        "type": "address"
      }
    ],
    "type": "error",
    "name": "OnlyCoordinatorCanFulfill"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "owner",
        "type": "address"
      }
    ],
    "type": "error",
    "name": "OwnableInvalidOwner"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "account",
        "type": "address"
      }
    ],
    "type": "error",
    "name": "OwnableUnauthorizedAccount"
  },
  {
    "inputs": [],
    "type": "error",
    "name": "dNFT__NoTokensInRaffle"
  },
  {
    "inputs": [],
    "type": "error",
    "name": "dNFT__NotEnoughETHSent"
  },
  {
    "inputs": [],
    "type": "error",
    "name": "dNFT__NotEnoughFunds"
  },
  {
    "inputs": [],
    "type": "error",
    "name": "dNFT__NotTokenOwner"
  },
  {
    "inputs": [],
    "type": "error",
    "name": "dNFT__RaffleNotExist"
  },
  {
    "inputs": [],
    "type": "error",
    "name": "dNFT__RaffleNotOpen"
  },
  {
    "inputs": [],
    "type": "error",
    "name": "dNFT__TokenNotForSale"
  },
  {
    "inputs": [],
    "type": "error",
    "name": "dNFT__TransferFailed"
  },
  {
    "inputs": [],
    "type": "error",
    "name": "dNFT__UpkeepNotNeeded"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "owner",
        "type": "address",
        "indexed": true
      },
      {
        "internalType": "address",
        "name": "approved",
        "type": "address",
        "indexed": true
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256",
        "indexed": true
      }
    ],
    "type": "event",
    "name": "Approval",
    "anonymous": false
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "owner",
        "type": "address",
        "indexed": true
      },
      {
        "internalType": "address",
        "name": "operator",
        "type": "address",
        "indexed": true
      },
      {
        "internalType": "bool",
        "name": "approved",
        "type": "bool",
        "indexed": false
      }
    ],
    "type": "event",
    "name": "ApprovalForAll",
    "anonymous": false
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_fromTokenId",
        "type": "uint256",
        "indexed": false
      },
      {
        "internalType": "uint256",
        "name": "_toTokenId",
        "type": "uint256",
        "indexed": false
      }
    ],
    "type": "event",
    "name": "BatchMetadataUpdate",
    "anonymous": false
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "expectedPrice",
        "type": "uint256",
        "indexed": false
      },
      {
        "internalType": "uint256",
        "name": "settleTime",
        "type": "uint256",
        "indexed": false
      }
    ],
    "type": "event",
    "name": "CreatedBet",
    "anonymous": false
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "raffleId",
        "type": "uint256",
        "indexed": false
      },
      {
        "internalType": "uint256",
        "name": "entranceFee",
        "type": "uint256",
        "indexed": false
      },
      {
        "internalType": "uint256",
        "name": "interval",
        "type": "uint256",
        "indexed": false
      }
    ],
    "type": "event",
    "name": "CreatedRaffle",
    "anonymous": false
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "player",
        "type": "address",
        "indexed": true
      },
      {
        "internalType": "uint256",
        "name": "BetId",
        "type": "uint256",
        "indexed": false
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256",
        "indexed": false
      },
      {
        "internalType": "bool",
        "name": "betChoice",
        "type": "bool",
        "indexed": false
      }
    ],
    "type": "event",
    "name": "EnteredBet",
    "anonymous": false
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "player",
        "type": "address",
        "indexed": true
      },
      {
        "internalType": "uint256",
        "name": "raffleNumber",
        "type": "uint256",
        "indexed": false
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256",
        "indexed": false
      }
    ],
    "type": "event",
    "name": "EnteredRaffle",
    "anonymous": false
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_tokenId",
        "type": "uint256",
        "indexed": false
      }
    ],
    "type": "event",
    "name": "MetadataUpdate",
    "anonymous": false
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "previousOwner",
        "type": "address",
        "indexed": true
      },
      {
        "internalType": "address",
        "name": "newOwner",
        "type": "address",
        "indexed": true
      }
    ],
    "type": "event",
    "name": "OwnershipTransferred",
    "anonymous": false
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "buyer",
        "type": "address",
        "indexed": true
      },
      {
        "internalType": "address",
        "name": "seller",
        "type": "address",
        "indexed": true
      },
      {
        "internalType": "uint256",
        "name": "price",
        "type": "uint256",
        "indexed": false
      }
    ],
    "type": "event",
    "name": "Purchase",
    "anonymous": false
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "randomNum",
        "type": "uint256",
        "indexed": false
      }
    ],
    "type": "event",
    "name": "RandomNum",
    "anonymous": false
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_tokenId",
        "type": "uint256",
        "indexed": false
      }
    ],
    "type": "event",
    "name": "RemoveFromSale",
    "anonymous": false
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "from",
        "type": "address",
        "indexed": true
      },
      {
        "internalType": "address",
        "name": "to",
        "type": "address",
        "indexed": true
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256",
        "indexed": true
      }
    ],
    "type": "event",
    "name": "Transfer",
    "anonymous": false
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_tokenId",
        "type": "uint256",
        "indexed": false
      },
      {
        "internalType": "uint256",
        "name": "_price",
        "type": "uint256",
        "indexed": false
      }
    ],
    "type": "event",
    "name": "UpdatePrice",
    "anonymous": false
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "raffleId",
        "type": "uint256",
        "indexed": false
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256",
        "indexed": false
      },
      {
        "internalType": "uint256",
        "name": "score",
        "type": "uint256",
        "indexed": false
      }
    ],
    "type": "event",
    "name": "UpdatedScore",
    "anonymous": false
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "winner",
        "type": "address",
        "indexed": true
      },
      {
        "internalType": "uint256",
        "name": "winningTokenId",
        "type": "uint256",
        "indexed": false
      },
      {
        "internalType": "uint256",
        "name": "amount",
        "type": "uint256",
        "indexed": false
      }
    ],
    "type": "event",
    "name": "Winner",
    "anonymous": false
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "to",
        "type": "address"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function",
    "name": "MintNFT"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "to",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function",
    "name": "approve"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "owner",
        "type": "address"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "name": "balanceOf",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ]
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_tokenId",
        "type": "uint256"
      }
    ],
    "stateMutability": "payable",
    "type": "function",
    "name": "buyToken"
  },
  {
    "inputs": [
      {
        "internalType": "bytes",
        "name": "",
        "type": "bytes"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function",
    "name": "checkUpkeep",
    "outputs": [
      {
        "internalType": "bool",
        "name": "upkeepNeeded",
        "type": "bool"
      },
      {
        "internalType": "bytes",
        "name": "",
        "type": "bytes"
      }
    ]
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_expectedPrice",
        "type": "uint256"
      },
      {
        "internalType": "uint256",
        "name": "_settleTime",
        "type": "uint256"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function",
    "name": "createBet"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "entranceFee",
        "type": "uint256"
      },
      {
        "internalType": "uint256",
        "name": "interval",
        "type": "uint256"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function",
    "name": "createRaffle"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "RaffleNumber",
        "type": "uint256"
      }
    ],
    "stateMutability": "payable",
    "type": "function",
    "name": "enterRaffle"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "name": "getApproved",
    "outputs": [
      {
        "internalType": "address",
        "name": "",
        "type": "address"
      }
    ]
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "betId",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "name": "getBets",
    "outputs": [
      {
        "internalType": "struct dNFT.ReturnBet",
        "name": "",
        "type": "tuple",
        "components": [
          {
            "internalType": "uint256",
            "name": "expectedPrice",
            "type": "uint256"
          },
          {
            "internalType": "uint256",
            "name": "betTime",
            "type": "uint256"
          },
          {
            "internalType": "uint256",
            "name": "settleTime",
            "type": "uint256"
          },
          {
            "internalType": "uint256[]",
            "name": "participantTokenIdList",
            "type": "uint256[]"
          },
          {
            "internalType": "enum dNFT.RaffleState",
            "name": "BetState",
            "type": "uint8"
          }
        ]
      }
    ]
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "name": "getBuyNumberByTokenId",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ]
  },
  {
    "inputs": [],
    "stateMutability": "view",
    "type": "function",
    "name": "getChainlinkDataFeedLatestAnswer",
    "outputs": [
      {
        "internalType": "int256",
        "name": "",
        "type": "int256"
      }
    ]
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_raffleId",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "name": "getLastTimeStamp",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ]
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "betId",
        "type": "uint256"
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "name": "getParticipantBet",
    "outputs": [
      {
        "internalType": "bool",
        "name": "",
        "type": "bool"
      }
    ]
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_tokenId",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "name": "getPrice",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ]
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_raffleId",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "name": "getRaffleFee",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ]
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_raffleId",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "name": "getRaffleIdByTokenId",
    "outputs": [
      {
        "internalType": "uint256[]",
        "name": "",
        "type": "uint256[]"
      }
    ]
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "raffleId",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "name": "getRaffleState",
    "outputs": [
      {
        "internalType": "enum dNFT.RaffleState",
        "name": "",
        "type": "uint8"
      }
    ]
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "raffleId",
        "type": "uint256"
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "name": "getTokenScoreByRaffle",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ]
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_raffleId",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "name": "getfundsByRaffleId",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ]
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "owner",
        "type": "address"
      },
      {
        "internalType": "address",
        "name": "operator",
        "type": "address"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "name": "isApprovedForAll",
    "outputs": [
      {
        "internalType": "bool",
        "name": "",
        "type": "bool"
      }
    ]
  },
  {
    "inputs": [],
    "stateMutability": "view",
    "type": "function",
    "name": "name",
    "outputs": [
      {
        "internalType": "string",
        "name": "",
        "type": "string"
      }
    ]
  },
  {
    "inputs": [],
    "stateMutability": "view",
    "type": "function",
    "name": "owner",
    "outputs": [
      {
        "internalType": "address",
        "name": "",
        "type": "address"
      }
    ]
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "name": "ownerOf",
    "outputs": [
      {
        "internalType": "address",
        "name": "",
        "type": "address"
      }
    ]
  },
  {
    "inputs": [
      {
        "internalType": "bytes",
        "name": "",
        "type": "bytes"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function",
    "name": "performUpkeep"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "betId",
        "type": "uint256"
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      },
      {
        "internalType": "bool",
        "name": "betChoice",
        "type": "bool"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function",
    "name": "placeBet"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "name": "prices",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ]
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "requestId",
        "type": "uint256"
      },
      {
        "internalType": "uint256[]",
        "name": "randomWords",
        "type": "uint256[]"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function",
    "name": "rawFulfillRandomWords"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_tokenId",
        "type": "uint256"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function",
    "name": "removeTokenSale"
  },
  {
    "inputs": [],
    "stateMutability": "nonpayable",
    "type": "function",
    "name": "renounceOwnership"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "from",
        "type": "address"
      },
      {
        "internalType": "address",
        "name": "to",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function",
    "name": "safeTransferFrom"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "from",
        "type": "address"
      },
      {
        "internalType": "address",
        "name": "to",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      },
      {
        "internalType": "bytes",
        "name": "data",
        "type": "bytes"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function",
    "name": "safeTransferFrom"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "operator",
        "type": "address"
      },
      {
        "internalType": "bool",
        "name": "approved",
        "type": "bool"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function",
    "name": "setApprovalForAll"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_tokenId",
        "type": "uint256"
      },
      {
        "internalType": "uint256",
        "name": "_price",
        "type": "uint256"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function",
    "name": "setPrice"
  },
  {
    "inputs": [
      {
        "internalType": "bytes4",
        "name": "interfaceId",
        "type": "bytes4"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "name": "supportsInterface",
    "outputs": [
      {
        "internalType": "bool",
        "name": "",
        "type": "bool"
      }
    ]
  },
  {
    "inputs": [],
    "stateMutability": "view",
    "type": "function",
    "name": "symbol",
    "outputs": [
      {
        "internalType": "string",
        "name": "",
        "type": "string"
      }
    ]
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "requestId",
        "type": "uint256"
      },
      {
        "internalType": "uint256[]",
        "name": "randomWords",
        "type": "uint256[]"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function",
    "name": "testFulfillRandomWords"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "name": "tokenURI",
    "outputs": [
      {
        "internalType": "string",
        "name": "",
        "type": "string"
      }
    ]
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "from",
        "type": "address"
      },
      {
        "internalType": "address",
        "name": "to",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "tokenId",
        "type": "uint256"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function",
    "name": "transferFrom"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "newOwner",
        "type": "address"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function",
    "name": "transferOwnership"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "betId",
        "type": "uint256"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function",
    "name": "updateBetScore"
  }
]