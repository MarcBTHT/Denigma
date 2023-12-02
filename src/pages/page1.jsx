import React from "react";
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import { abi, contractAddress } from "../constants.js"
import './page1.css'
import {Link, BrowserRouter as Router, Route, Routes} from 'react-router-dom';

function Page1() {
    const [connectionStatus, setConnectionStatus] = useState('Disconnected');
    const [entranceFee, setEntranceFee] = useState('');
    const [interval, setInterval] = useState('');
    const [raffleNumber, setRaffleNumber] = useState('');
    const [ethAmount, setEthAmount] = useState('');

    const [raffleId, setRaffleId] = useState('');
    const [raffleFee, setRaffleFee] = useState('');
    const [raffleFunds, setRaffleFunds] = useState('');

    const [raffleState, setRaffleState] = useState('');

    // States for bet creation
    const [expectedPrice, setExpectedPrice] = useState('');
    const [settleTime, setSettleTime] = useState('');

    // States for entering a bet
    const [betId, setBetId] = useState('');
    const [betChoice, setBetChoice] = useState(false); // true or false depending on the user's bet
    const [tokenId, setTokenId] = useState('');

    const [tokenScore, setTokenScore] = useState('');

    const [tokenImage, setTokenImage] = useState(null);
    const [tokenName, setTokenName] = useState('');

    async function connect() {
        if (typeof window.ethereum !== "undefined") {
          try {
            await ethereum.request({ method: "eth_requestAccounts" })
            setConnectionStatus('Connected'); // Update button text
            const accounts = await ethereum.request({ method: "eth_accounts" })
            console.log(accounts)
          } catch (error) {
            console.log(error)
          }
        } else {
          setConnectionStatus('Please install MetaMask'); // Update button text
        }
    }
    async function createRaffle() {
      if (typeof window.ethereum !== "undefined") {
          const provider = new ethers.providers.Web3Provider(window.ethereum);
          const signer = provider.getSigner();
          const contract = new ethers.Contract(contractAddress, abi, signer);

          try {
              await contract.createRaffle(ethers.utils.parseEther(entranceFee), interval);
              console.log(`Raffle created with entrance fee: ${entranceFee} ETH and interval: ${interval}`);
          } catch (error) {
              console.error(error);
          }
      }
  }
  async function enterRaffle() {
    if (typeof window.ethereum !== "undefined") {
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const signer = provider.getSigner();
        const contract = new ethers.Contract(contractAddress, abi, signer);

        try {
            const transactionResponse = await contract.enterRaffle(raffleNumber, { value: ethers.utils.parseEther(ethAmount) });
            await provider.waitForTransaction(transactionResponse.hash);
            console.log(`Entered raffle number: ${raffleNumber} with ${ethAmount} ETH`);
        } catch (error) {
            console.error(error);
        }
    }
  }
  async function fetchRaffleFee() {
        if (typeof window.ethereum !== "undefined") {
            const provider = new ethers.providers.Web3Provider(window.ethereum);
            const contract = new ethers.Contract(contractAddress, abi, provider);

            try {
                const fee = await contract.getRaffleFee(raffleId);
                setRaffleFee(ethers.utils.formatEther(fee));
            } catch (error) {
                console.error(error);
            }
        }
    }

    async function fetchRaffleFunds() {
      if (typeof window.ethereum !== "undefined") {
          const provider = new ethers.providers.Web3Provider(window.ethereum);
          const contract = new ethers.Contract(contractAddress, abi, provider);

          try {
              const funds = await contract.getfundsByRaffleId(raffleId);
              setRaffleFunds(ethers.utils.formatEther(funds));
          } catch (error) {
              console.error(error);
          }
      }
  }
  async function fetchRaffleState() {
    if (typeof window.ethereum !== "undefined") {
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const contract = new ethers.Contract(contractAddress, abi, provider);

        try {
            const state = await contract.getRaffleState(raffleId);
            setRaffleState(state.toString()); // Assuming RaffleState is an enum or similar
        } catch (error) {
            console.error(error);
        }
    }
  }
  async function createBet() {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const contract = new ethers.Contract(contractAddress, abi, signer);

    try {
        const tx = await contract.createBet(ethers.utils.parseEther(expectedPrice), settleTime);
        await tx.wait();
        console.log('Bet created successfully');
    } catch (error) {
        console.error('Error creating bet:', error);
    }
  }

  async function enterBet() {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const contract = new ethers.Contract(contractAddress, abi, signer);

    try {
        const tx = await contract.placeBet(betId, tokenId, betChoice);
        await tx.wait();
        console.log('Entered bet successfully');
    } catch (error) {
        console.error('Error entering bet:', error);
    }
    }
  async function fetchTokenScore() {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const contract = new ethers.Contract(contractAddress, abi, signer);

    try {
        const score = await contract.getTokenScoreByRaffle(raffleId, tokenId);
        setTokenScore(score.toString());
    } catch (error) {
        console.error('Error fetching token score:', error);
    }
  }
  async function fetchTokenURI() {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const contract = new ethers.Contract(contractAddress, abi, signer);

    try {
        const uri = await contract.tokenURI(tokenId);
        fetchTokenDetails(uri);
    } catch (error) {
        console.error('Error fetching token URI:', error);
    }
  }

  async function fetchTokenDetails(uri) {
    try {
        const response = await fetch(uri);
        const metadata = await response.json();
        setTokenImage(metadata.image); // Update the state with the fetched image URL
        setTokenName(metadata.name);   // Update the state with the fetched name
        setTokenScore(metadata.score); // Update the state with the fetched score
    } catch (error) {
        console.error('Error fetching token details:', error);
    }
  }
  const tokenImageStyle = {
    backgroundImage: `url(${tokenImage})`,
    backgroundSize: 'cover', // This ensures that the background image covers the entire div
    backgroundPosition: 'center', // This centers the background image
    height: '300px', // Set a height for your container
    width: '300px', // Set a width for your container
    // Add other styles as needed
  };



    return (
      <>
      <div>
          <button onClick={connect}>{connectionStatus}</button>
      </div>
      <div>
          <input 
              type="text" 
              placeholder="Entrance Fee in ETH" 
              value={entranceFee} 
              onChange={(e) => setEntranceFee(e.target.value)}
          />
          <input 
              type="text" 
              placeholder="Interval in seconds" 
              value={interval} 
              onChange={(e) => setInterval(e.target.value)}
          />
          <button onClick={createRaffle}>Create Raffle</button>
      </div>
      <div>
          <input 
            type="number" 
            placeholder="Raffle Number" 
            value={raffleNumber} 
            onChange={(e) => setRaffleNumber(e.target.value)}
            />
          <input 
            type="text" 
            placeholder="ETH Amount" 
            value={ethAmount} 
            onChange={(e) => setEthAmount(e.target.value)}
            />
          <button onClick={enterRaffle}>Enter Raffle</button>
      </div>
      <div>
          <input 
            type="number" 
            placeholder="Raffle ID" 
            value={raffleId} 
            onChange={(e) => setRaffleId(e.target.value)}
            />
          <button onClick={fetchRaffleFee}>Fetch Raffle Fee</button>
            {raffleFee && <p>Raffle Fee: {raffleFee} ETH</p>}
          <button onClick={fetchRaffleFunds}>Fetch Raffle Funds</button>
            {raffleFunds && <p>Raffle Funds: {raffleFunds} ETH</p>}
          <button onClick={fetchRaffleState}>Fetch Raffle State</button>
            {raffleState && <p>Raffle State: {raffleState}</p>}
      </div>
      {/* UI for creating a bet */}
      <div>
        <input 
          type="text" 
          placeholder="Expected Price" 
          value={expectedPrice} 
          onChange={(e) => setExpectedPrice(e.target.value)}
        />
        <input 
          type="text" 
          placeholder="Settle Time in seconds" 
          value={settleTime} 
          onChange={(e) => setSettleTime(e.target.value)}
        />
        <button onClick={createBet}>Create Bet</button>
      </div>
      {/* UI for entering a bet */}
      <div>
        <input 
          type="number" 
          placeholder="Bet ID" 
          value={betId} 
          onChange={(e) => setBetId(e.target.value)}
        />
        <input 
          type="number" 
          placeholder="Token ID" 
          value={tokenId} 
          onChange={(e) => setTokenId(e.target.value)}
        />
        <input 
          type="checkbox" 
          checked={betChoice} 
          onChange={(e) => setBetChoice(e.target.checked)}
        />
        <button onClick={enterBet}>Enter Bet</button>
      </div>
       {/* UI for fetching token score */}
      <div>
          <input 
            type="number" 
            placeholder="Raffle ID" 
            value={raffleId} 
            onChange={(e) => setRaffleId(e.target.value)}
          />
          <input 
            type="number" 
            placeholder="Token ID" 
            value={tokenId} 
            onChange={(e) => setTokenId(e.target.value)}
          />
          <button onClick={fetchTokenScore}>Fetch Token Score</button>
          {tokenScore && <p>Token Score: {tokenScore}</p>}
      </div>
      {/* UI for fetching and displaying token details */}
      <div>
            <input 
                type="number" 
                placeholder="Token ID" 
                value={tokenId} 
                onChange={(e) => setTokenId(e.target.value)}
            />
            <button onClick={fetchTokenURI}>Fetch Token Details</button>

            {/* Display the token details here */}
            <div style={tokenImageStyle}>
            {/* Overlay Content */}
            <div className="token-details">
                {tokenName && <p>Name: {tokenName}</p>}
                {tokenScore && <p>Score: {tokenScore}</p>}
            </div>
            </div>
        </div>
      <div>
          <Link to="/">Go back home</Link>
      </div>
    </>
    )
}

export default Page1