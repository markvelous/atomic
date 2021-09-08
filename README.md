# ATOMIC SWAP

Mark Tan

## QUICKSTART

```
npm install truffle
```

Clone the repo

```
npm i 
npm i @truffle/hdwallet-provider
npm i @openzeppelin/contracts@3.4.0
```

Create 2 sets of accounts on Metamask or at [vanity-eth](https://vanity-eth.tk/) for Ethereum & Binance 

truffle migrate --reset --network kovan
truffle migrate --reset --network binanceTestnet

// Checks accounts and HTLC on Binance testnet
truffle console --network binanceTestnet
const addresses = await web3.eth.getAccounts()
    addresses

// check HTLC
const htlc = await HTLC.deployed()
    htlc.address

// Alice initiates by withdrawing the fund
await htlc.withdraw('remarkable', {from: addresses[0]})

/// verify balance
const token = await Token.deployed()
const balance = await token.balanceOf(addresses[0])
    balance.toString()

// Checks accounts and HTLC on Binance testnet
truffle console --network kovan
const addresses = await web3.eth.getAccounts()
    addresses

// check HTLC
const htlc = await HTLC.deployed()
    htlc.address

// Bob checks Binance for the secret
const mySecret = await htlc.secret()
    mySecret

// Bob goes back to Kovan to unlock the fund
await htlc.withdraw('remarkable', {from addresses[1]})

// verify that token was received
const token = await Token.deployed()
const balance = await token.balanceOf(addresses[1])
    balance.toString()