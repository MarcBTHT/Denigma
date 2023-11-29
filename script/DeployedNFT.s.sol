// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console2} from "forge-std/Script.sol";
import {dNFT} from "../src/dNFT.sol";

contract DeployedNFT is Script {
    address public myTestContractAddress = 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496; //Address of test contract
    address public myAnvil0Address = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266; //Anvil 0
    address public mySepoliaAddress = 0xc29dEE36CEaF01B276002CDF894814A2b3Fa8aAf;

    address public vrfCoordinator = 0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625; //COORDINATOR SEPOLIA
    address public vrfCoordinatorFUJI = 0x2eD832Ba664535e5886b75D64C46EB9a228C2610; //COORDINATOR FUJI
    uint64 public constant subscriptionId = 6990; //Subscription ID for the VRF (ETH SEPOLIA)
    uint64 public constant subscriptionIdFUJI = 793; //Subscription ID for the VRF (FUJI)

    function run() external returns (dNFT) {
        vm.startBroadcast();
        dNFT dnft = new dNFT(mySepoliaAddress,vrfCoordinatorFUJI,subscriptionIdFUJI); 
        vm.stopBroadcast();
        return dnft;
    }
}