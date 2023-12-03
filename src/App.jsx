import React from "react";
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import { abi, contractAddress } from "./constants.js"
import './App.css'
import {Link, BrowserRouter as Router, Route, Routes} from 'react-router-dom';
import Page1 from './pages/page1.jsx'

function App() {
  const [connectionStatus, setConnectionStatus] = useState('Disconnected'); 
  const [tokenId, setTokenId] = useState('');
  const [price, setPrice] = useState('');
  const [fetchedPrice, setFetchedPrice] = useState('');
  const [ethAmount, setEthAmount] = useState('');

  const handleTokenIdChange = (e) => {
    setTokenId(e.target.value);
  };

  // Function to handle changes in the price input
  const handlePriceChange = (e) => {
    setPrice(e.target.value);
  };

  // Function to set the NFT price, triggered by a button click
  const handleSetNFTPrice = async () => {
    await setNFTPrice(tokenId, price);
  };

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
  async function setNFTPrice(tokenId, price) {
    if (typeof window.ethereum !== "undefined") {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const contract = new ethers.Contract(contractAddress, abi, signer);

      try {
        const signerAddress = await signer.getAddress();
        const transactionResponse = await contract.setPrice(tokenId, ethers.utils.parseEther(price));
        await provider.waitForTransaction(transactionResponse.hash);
        console.log(`${signerAddress} set the price for Token ID ${tokenId}. Price: ${price} ETH`);
      } catch (error) {
        console.error(error);
      }
    }
  }
  async function fetchPrice(tokenId) {
    if (typeof window.ethereum !== "undefined") {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const contract = new ethers.Contract(contractAddress, abi, provider);
  
      try {
        const price = await contract.getPrice(tokenId);
        setFetchedPrice(ethers.utils.formatEther(price));
        console.log(`Price for Token ID ${tokenId}: ${price} Wei`);
      } catch (error) {
        console.error(error);
      }
    }
  }
  async function removeTokenFromSale(tokenId) {
    if (typeof window.ethereum !== "undefined") {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const contract = new ethers.Contract(contractAddress, abi, signer);
  
      try {
        const transactionResponse = await contract.removeTokenSale(tokenId);
        await provider.waitForTransaction(transactionResponse.hash);
        console.log(`Token ID ${tokenId} removed from sale.`);
      } catch (error) {
        console.error(error);
      }
    }
  }
  async function buyToken(tokenId, ethAmount) {
    if (typeof window.ethereum !== "undefined") {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const contract = new ethers.Contract(contractAddress, abi, signer);
  
      try {
        const signerAddress = await signer.getAddress();
        const transactionResponse = await contract.buyToken(tokenId, { value: ethers.utils.parseEther(ethAmount) });
        await provider.waitForTransaction(transactionResponse.hash);
        console.log(`Token ID ${tokenId} purchased by ${signerAddress} for ${ethAmount} ETH. Transaction hash: ${transactionResponse.hash}`);
      } catch (error) {
        console.error(error);
      }
    }
  }
  
  useEffect(() => { //TO know when I have a winner. This is a listener, we wait to have the emit of Winner()
    // Event listener setup
    if (typeof window.ethereum !== "undefined") {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const contract = new ethers.Contract(contractAddress, abi, provider);

      const onWinner = (winner) => {
        console.log(`Winner: ${winner}`);
      };

      contract.on("Winner", onWinner);

      // Cleanup
      return () => {
        contract.off("Winner", onWinner);
      };
    }
  }, []);

  
  
  return (
    <Router>
      <Routes>
      <Route exact path="/" element={<>
      <div>
        <button onClick={connect}>{connectionStatus}</button>
      </div>
      <div>
        <input type="number" placeholder="Token ID" value={tokenId} onChange={handleTokenIdChange}/>
        <input type="text" placeholder="Price in ETH" value={price} onChange={handlePriceChange}/>
        <button onClick={handleSetNFTPrice}>Set Price</button>
      </div>
      <div>
        <input type="number" placeholder="Token ID" value={tokenId} onChange={(e) => setTokenId(e.target.value)}/>
        <button onClick={() => fetchPrice(tokenId)}>Fetch Price</button>
        {fetchedPrice && <p>Price: {fetchedPrice} ETH</p>}
      </div>
      <div>
        <input type="number" placeholder="Token ID" value={tokenId} onChange={(e) => setTokenId(e.target.value)}/>
        <button onClick={() => removeTokenFromSale(tokenId)}>Remove Token from Sale</button>
      </div>
      <div>
        <input type="number" placeholder="Token ID" value={tokenId} onChange={(e) => setTokenId(e.target.value)}/>
        <input type="text" placeholder="Amount in ETH" value={ethAmount} onChange={(e) => setEthAmount(e.target.value)}/>
        <button onClick={() => buyToken(tokenId, ethAmount)}>Buy Token</button>
      </div>
      <div> 
        <Link to="/page1">Next Page</Link>
      </div>
      </>}/>
      <Route exact path="/page1" element={<Page1/>} />
      </Routes>
    </Router>
  )
}

export default App
