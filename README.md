## Installation
- Install yarn via npm: npm install --global yarn
- Create a new Vite project: yarn create vite my-project cd my-project
- Install dependencies: yarn
- npm install ethers@5.7.2
- yarn add react-router-dom
- Run the project: yarn run dev

## Deploy your contract

- Add to the terminal the variables : source .env
- forge script script/Token.s.sol --rpc-url $RPC_URL --broadcast --private-key $PRIVATE_KEY
- forge script script/Token.s.sol --rpc-url $SEPOLIA_RPC_URL --private-key $SEPOLIA_PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY
