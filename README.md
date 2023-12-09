# Denigma

## Overview 🌟
"Unleash Your Potential: Engage, Collaborate, Succeed!" Step into our innovative blockchain experience! Our platform combines the thrill of interactive gameplay, the power of community engagement, and the charm of personal storytelling within a dynamic digital environment.

## Table of Contents 📑
- [Problem Statement](#problem-statement-)
- [Solution](#solution-)
- [Features](#features-)
- [Community Focus](#community-focus-)
- [Advantages](#advantages-)
- [Product](#product-)
- [Getting Started](#getting-started-)

## Problem Statement ⚠️
Traditional digital experiences often lack interactive, educational, and secure elements. Users typically engage in passive activities with limited control, meaningful interaction, or assurance of fairness and security. 

## Solution 📜
We're redefining the digital experience, creating a space where user actions and community interactions shape their journey and enhance their chances of success. This innovative approach combines gaming, personal expression, and active community involvement in a secure, fair, and transparent setting.

## Features ✨
  - **Personalization & Customization**: Tailor your digital assets (NFTs) and contribute to a shared digital landscape.
  - **Engaging Storylines**: Participate in narrative-driven adventures where your decisions have a real impact.
  - **Educational and Thematic Challenges**: Explore subjects like finance, history, science through engaging activities.
  - **Competitive Elements & Recognition**: Take part in community challenges, earn your place in the rankings and receive rewards.

## Community Focus 🌐
  - **Real-World Integration**: Engage in activities that bridge digital and physical realms, offering real-life rewards.
  - **Social Impact Initiatives**: Get involved in social causes and contribute to meaningful projects.
  - **Ongoing Events and Updates**: Enjoy events tied to current trends and community feedback.

## Advantages 💎
- **Engaging & Educational**: An active, fun-filled journey of learning.
- **Community Building**: Fosters collaboration and social connections.
- **Dynamic & Inclusive**: Regular updates and diverse content for broad appeal.
- **Socially Responsible**: Contributes to societal causes through thematic lotteries.

## Product 🛠️

### Diagram:
![image](https://github.com/MarcBTHT/Denigma/assets/116173196/cdece12e-6e44-41c6-9472-1df3d2ef82a8)

### WebSite:
- [**Denigma Site Repository**](https://github.com/MarcBTHT/Denigma-site) on GitHub for source code and more.
- [**Live Site**](https://denigma-site.vercel.app/): Check out the live version of Denigma. 

### Code Reference:
Explore key functionalities in our code:
- **Chainlink Integrations**:
  - [**Chainlink Automation**](https://github.com/MarcBTHT/Denigma/blob/main/src/dNFT.sol#L319): Implementation details in our code base.
  - [**Chainlink VRF**](https://github.com/MarcBTHT/Denigma/blob/main/src/dNFT.sol#L360): Integration of Chainlink VRF.
  - [**Chainlink Data Feed**](https://github.com/MarcBTHT/Denigma/blob/main/src/dNFT.sol#L400): Chainlink Data Feed integration.
  - [**Chainlink Functions**](https://github.com/mathieulrl/functions-hardhat-starter-kit): Repository containing Enigma's Chainlink Function calls, including interactions with ChatGPT API.
  - **Chainlink CCIP**:
    - [**Receiver Contract**](https://github.com/MarcBTHT/Denigma/blob/main/src/CCIP/dNFT.sol#L441): CCIP receiver implementation in our smart contract.
    - [**Receiver Contract Additional Code**](https://github.com/MarcBTHT/Denigma/blob/main/src/CCIP/dNFT.sol#L336): Update dNft state. 
    - [**Sender Contract**](https://github.com/MarcBTHT/Denigma/blob/main/src/CCIP/Sender.sol#L35): Implementation of the CCIP sender smart contract.
    - Please note: The CCIP functionality is currently experiencing issues, particularly with data transmission to the receiver contract. We are actively working to resolve these problems.

- **Core Smart Contract Features**:
  - [**Functions**](https://github.com/MarcBTHT/Denigma/blob/main/src/dNFT.sol#L145): Overview of the main functions in our smart contract.
  - [**Buy and Sell Token Logic**](https://github.com/MarcBTHT/Denigma/blob/main/src/dNFT.sol#L195): Detailed implementation of buy and sell token functionalities.
  - [**Update dNFT**](https://github.com/MarcBTHT/Denigma/blob/main/src/dNFT.sol#L256): Code for updating dNFT.
  - [**Metadata Implementation**](https://github.com/MarcBTHT/Denigma/blob/main/src/dNFT.sol#L413): Metadata functionalities in our contract.
 
### Deployment Strategy
**Avalanche (AVAX) Network Usage**:
- We chose the Avalanche network for deploying our smart contracts due to its rapid transaction processing and lower costs. This choice enhances the efficiency and accessibility of our platform.

## Getting Started 🚀

### Installation:

**a) Deploy a new contract:**
- Using Foundry :
	1) forge init new_project
  	2) forge install openzeppelin/openzeppelin-contracts --no-commit
  	3) forge install smartcontractkit/chainlink-brownie-contracts@0.6.1 --no-commit
  	4) Import dNFT.sol and DeployedNFT.s.sol
  	5) Update .env
  	6) forge script script/DeployedNFT.s.sol --rpc-url $FUJI_RPC_URL --private-key $SEPOLIA_PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY
  	7) Create a subscription : https://vrf.chain.link/sepolia/ and add a consumer address (Contract address)
  	8) Create a new Upkeep : https://automation.chain.link/sepolia/ and use Custom logic
  	9) Create a new Upkeep with Time-based to call updateBetScore(0)
  	10) Setup CCIP :
  	      1) Deploy Receiver Contract (dNFT) : 0x554472a2720e5e7d5d3c817529aba05eed5f82d8 (ROUTER FUJI)
  	      2) Deploy Sender Contract : 0xD0daae2231E9CB96b94C8512223533293C3693Bf (ROUTER SEPOLIA), 0x779877A7B0D9E8603169DdbD7836e478b4624789 (LINK SEPOLIA) and write on it the receiver address.
  	      3) Fund with link the Sender Contract
  	      4) You can stack your token. Just verify 14767482510784806043 (Chain selector Fuji)

**b) Run the site:**
- [**Denigma Site Repository**](https://github.com/MarcBTHT/Denigma-site) : To run the site, please visit the following repository for source code, detailed instructions, and more.
