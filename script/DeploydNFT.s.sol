// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console2} from "forge-std/Script.sol";
import {dNFT} from "../src/dNFT.sol";

contract DeploydNFT is Script {
    address public myAddress = 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496; //Address of test contract
    //address public myAddress = 0x2C4B7f7244e93523E770Bef9820E79Fa88d32F3f; 
    function run() external returns (dNFT) {
        vm.startBroadcast();
        dNFT dnft = new dNFT(myAddress);
        vm.stopBroadcast();
        return dnft;
    }
}