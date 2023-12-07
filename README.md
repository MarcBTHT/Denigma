# Denigma

## Overview 🌟
"Unleash Your Potential: Engage, Collaborate, Succeed!" Step into our innovative blockchain experience! Our platform combines the thrill of interactive gameplay, the power of community engagement, and the charm of personal storytelling within a dynamic digital environment.

## Table of Contents 📑
- [Problem Statement](#problem-statement)
- [Solution](#solution)
- [Features](#features)
- [Community Focus](#community-focus)
- [Advantages](#advantages)
- [Product](#product)
- [Getting Started](#getting-started)

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
![image](https://github.com/MarcBTHT/Denigma/assets/116173196/e4cada7d-26d2-4563-a3c5-12c8dd3a5bf5)

## Getting Started 🚀

### Installation:

**a) Deploy a new contract:**
- Using Foundry :
	1) forge init new_project
  	2) forge install openzeppelin/openzeppelin-contracts --no-commit
  	3) forge install smartcontractkit/chainlink-brownie-contracts@0.6.1 --no-commit
  	4) Import dNFT.sol and DeployedNFT.s.sol
  	5) Update .env
  	6) forge script script/DeployedNFT.s.sol --rpc-url $SEPOLIA_RPC_URL --private-key $SEPOLIA_PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY
  	7) Create a subscription : https://vrf.chain.link/sepolia/ and add a consumer address (Contract address)
  	8) Create a new Upkeep : https://automation.chain.link/sepolia/ and use Custom logic
  	9) Create a new Upkeep with Time-based to call updateBetScore(0)
  	10) Setup CCIP :
  	      1) Deploy Receiver Contract (dNFT) : 0x554472a2720e5e7d5d3c817529aba05eed5f82d8 (ROUTER FUJI)
  	      2) Deploy Sender Contract : 0xD0daae2231E9CB96b94C8512223533293C3693Bf (ROUTER SEPOLIA), 0x779877A7B0D9E8603169DdbD7836e478b4624789 (LINK SEPOLIA) and write on it the receiver address.
  	      3) Fund with link the Sender Contract
  	      4) You can stack your token. Just verify 14767482510784806043 (Chain selector Fuji)

**b) Run the site :**
- Yarn - Vite:
	1) Install yarn via npm: npm install --global yarn
	2) Create a new Vite project: yarn create vite my-project
	3) cd my-project
	4) Install dependencies: 
  		- yarn
  		- npm install ethers@5.7.2
	5) Run the project: yarn run dev
