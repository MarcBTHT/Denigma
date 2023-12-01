# Interactive Blockchain Community Lottery

## Overview 🌟
"Transform Your Chance: Play, Enhance, Triumph!" Dive into our innovative blockchain lottery experience! This platform is a fusion of exciting gameplay, community-driven challenges, and personal storytelling, all set within a dynamic community environment.

## Table of Contents 📑
- [Problem Statement](#problem-statement)
- [Solution](#solution)
- [Features](#features)
- [Community Focus](#community-focus)
- [Benefits](#benefits)
- [Product](#product)
- [Getting Started](#getting-started)

## Problem Statement ⚠️
Traditional lotteries are often passive experiences lacking interactive or educational value. Participants buy tickets and wait, with no control over the outcome or opportunity for engagement.

## Solution 📜
Our platform reinvents the lottery by creating a space where players' actions and interactions directly influence their journey and chances of success. It’s a blend of gaming, personal expression, and community participation.

## Features ✨
- ### Personalization & Customization
  - **Customizable NFTs**: Players can personalize their NFTs, enhancing their connection to the game.
  - **User-Created Content**: Community members create and share their own challenges, fostering a collaborative environment.

- ### Interactive Storytelling
  - **Narrative-Driven Challenges**: Engage in story-based scenarios where choices and achievements shape the narrative.
  - **Role-Playing Elements**: Introduce immersive role-playing aspects for a deeper gaming experience.
    
- ### Thematic Challenges & Learning Modules
  - **Educational Themes**: Explore lotteries around themes like finance, history, science, enhancing the educational value.
  - **Interactive Learning Tasks**: Complete tasks related to themes, including watching videos, reading articles, and interactive lessons.

- ### Competition and Leaderboards
  - **Competitive Challenges**: Engage in leaderboard competitions with other community members.
  - **Rewards for Top Performers**: Recognize and reward top players to motivate continuous engagement.

## Community Focus 🌐
- ### Integration with Real-Life Activities
  - **Real-World Tasks**: Challenges that encourage real-world engagement, like attending events or exploring new topics.
  - **Tangible Rewards**: Partnerships offering real-life rewards, bridging the gap between virtual achievements and real-world benefits.

- ### Social Impact and Awareness
  - **Community Projects**: Opportunities for players to engage in social causes and community-driven initiatives.
  - **Awareness Campaigns**: Lotteries and events aligned with social causes, promoting awareness and positive impact.

- ### Regular Events and Updates
  - **Thematic Events**: Host events based on current trends, holidays, or global themes.
  - **Expert Collaborations**: Work with influencers or subject matter experts for special events and content.
 
- ### Gamification & Dynamic Content
  - **Tiered Challenges**: Offer different levels of challenges to cater to a wide audience.
  - **Dynamic Updates**: Regularly update content based on user feedback and trends.

## Benefits 💎
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
