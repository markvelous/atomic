# REMARKABLE ATOMIC SWAP

`SGBT4 PT7210027 Mark Tan, final assignment for Intermediate Blockchain module`

_tl;dr_: Demonstration of a DEX enabled by atomic swaps for peer-to-peer, full custody crypto-swapping without fees and with minimum risks (sufficient locked time should be catered for first-in-last-out of initiator to avoid eleventh-minute foulplay)

> Demo is executed on console; no UI
## SETUP

[Clone this repo](git clone https://github.com/markvelous/atomicswap)

Install the dependencies:
```
npm install truffle
npm i 
npm i @truffle/hdwallet-provider
npm i @openzeppelin/contracts@3.4.0
```

Create two sets of accounts for Kovan & Binance testnets on Metamask or at [vanity-eth](https://vanity-eth.tk/) 

The Metamask setup for Binance Testnet is as follows:
```
Network Name: Smart Chain - Testnet
New RPC URL: https://data-seed-prebsc-1-s1.binance.org:8545/
ChainID: 97
Symbol: BNB
Block Explorer URL: https://testnet.bscscan.com
```

Ensure sufficient funds in both accounts using the respective faucets:

[Binance Testnet](https://testnet.binance.org/faucet-smart)

[Kovan Testnet](https://gitter.im/kovan-testnet/faucet)

## LET'S DO ATOMIC SWAPS

Let's assume Alice is on Kovan & Bob is on Binance

>Alice initiates the atomic swaps with a secret; both deploy their contracts accordingly:

```bash
truffle migrate --reset --network kovan

truffle migrate --reset --network binanceTestnet
```

>Bob verifies the accounts and that his HTLC has been deployed on Binance
```bash
truffle console --network binanceTestnet

const addresses = await web3.eth.getAccounts()

addresses

const htlc = await HTLC.deployed()

htlc.address
```

>Bob withdraws the fund using the secret he has provided & verifies receipt of the fund
```bash
await htlc.withdraw('remarkable', {from: addresses[0]})

const token = await Token.deployed()

const balance = await token.balanceOf(addresses[0])

balance.toString()
```

>Alice verifies the accounts and HTLC on Kovan
```
truffle console --network kovan

const addresses = await web3.eth.getAccounts()

addresses

const htlc = await HTLC.deployed()

htlc.address
```

>Once Bob has acted on the HTLC & revealed the secret, Alice can retrieve the secret from Binance ...
```bash
const mySecret = await htlc.secret()

mySecret
```
>...to unlock her fund in Kovan
```
await htlc.withdraw('remarkable', {from: addresses[1]})

const token = await Token.deployed()

const balance = await token.balanceOf(addresses[1])

balance.toString()
```

And the atomic swap is completed successfully between peers without an exchange!