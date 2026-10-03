//
//  Trivia.swift
//  CryptoProfitCalculator
//
//  Created by Maicol Cabreja on 9/26/24.
//

import SwiftUI
import Combine

struct CryptoTriviaView: View {
    struct TriviaQuestion {
        let question: String
        let answers: [String]
        let correctAnswer: Int
        let explanation: String
    }
    
    struct TriviaChapter {
        let title: String
        let questions: [TriviaQuestion]
    }
    
    let chapters = [
        TriviaChapter(
            title: "Bitcoin & Blockchain Basics",
            questions: [
                TriviaQuestion(question: "What is Bitcoin?",
                               answers: ["A digital currency", "A physical coin", "A bank account", "A credit card"],
                               correctAnswer: 0,
                               explanation: "Bitcoin is a decentralized digital currency that operates on blockchain technology."),
                TriviaQuestion(question: "What is a blockchain?",
                               answers: ["A type of cryptocurrency", "A distributed ledger", "A bank", "A trading platform"],
                               correctAnswer: 1,
                               explanation: "A blockchain is a distributed ledger that records transactions across multiple computers."),
                TriviaQuestion(question: "Who created Bitcoin?",
                               answers: ["Satoshi Nakamoto", "Vitalik Buterin", "Elon Musk", "Mark Zuckerberg"],
                               correctAnswer: 0,
                               explanation: "Bitcoin was created by the pseudonymous Satoshi Nakamoto in 2008."),
                TriviaQuestion(question: "What is mining in Bitcoin?",
                               answers: ["Digging for coins", "Solving complex math problems", "Trading Bitcoin", "Storing Bitcoin"],
                               correctAnswer: 1,
                               explanation: "Mining involves solving complex mathematical problems to validate transactions and create new blocks."),
                TriviaQuestion(question: "What is a Bitcoin halving?",
                               answers: ["Cutting Bitcoin in half", "Reducing mining rewards by 50%", "Selling half your Bitcoin", "A type of fork"],
                               correctAnswer: 1,
                               explanation: "Bitcoin halving reduces the mining reward by 50% approximately every 4 years."),
                TriviaQuestion(question: "What is a private key?",
                               answers: ["A password for your bank", "A secret code to access your crypto", "A public address", "A trading pair"],
                               correctAnswer: 1,
                               explanation: "A private key is a secret code that allows you to access and control your cryptocurrency."),
                TriviaQuestion(question: "What is a public address?",
                               answers: ["Your home address", "A shareable crypto address", "A private key", "A wallet name"],
                               correctAnswer: 1,
                               explanation: "A public address is a shareable address where others can send you cryptocurrency."),
                TriviaQuestion(question: "What is the maximum supply of Bitcoin?",
                               answers: ["10 million", "100 million", "21 million", "Unlimited"],
                               correctAnswer: 2,
                               explanation: "Bitcoin has a maximum supply of 21 million coins."),
                TriviaQuestion(question: "What is a block in blockchain?",
                               answers: ["A building block", "A group of transactions", "A type of wallet", "A mining rig"],
                               correctAnswer: 1,
                               explanation: "A block is a group of transactions that are validated and added to the blockchain."),
                TriviaQuestion(question: "What is proof-of-work?",
                               answers: ["A type of wallet", "A consensus mechanism", "A trading strategy", "A security feature"],
                               correctAnswer: 1,
                               explanation: "Proof-of-work is a consensus mechanism that requires computational work to validate transactions.")
            ]
        ),
        TriviaChapter(
            title: "Ethereum, DeFi & More",
            questions: [
                TriviaQuestion(question: "What is Ethereum?",
                               answers: ["A cryptocurrency", "A blockchain platform", "A trading app", "A wallet"],
                               correctAnswer: 1,
                               explanation: "Ethereum is a blockchain platform that enables smart contracts and decentralized applications."),
                TriviaQuestion(question: "Who created Ethereum?",
                               answers: ["Satoshi Nakamoto", "Vitalik Buterin", "Charlie Lee", "Roger Ver"],
                               correctAnswer: 1,
                               explanation: "Ethereum was created by Vitalik Buterin in 2015."),
                TriviaQuestion(question: "What is DeFi?",
                               answers: ["Decentralized Finance", "Digital Finance", "Direct Finance", "Dynamic Finance"],
                               correctAnswer: 0,
                               explanation: "DeFi stands for Decentralized Finance, which provides financial services without intermediaries."),
                TriviaQuestion(question: "What is a smart contract?",
                               answers: ["A legal document", "Self-executing code on blockchain", "A trading agreement", "A wallet feature"],
                               correctAnswer: 1,
                               explanation: "A smart contract is self-executing code that runs on the blockchain when conditions are met."),
                TriviaQuestion(question: "What is gas in Ethereum?",
                               answers: ["A fuel", "Transaction fees", "A cryptocurrency", "A mining reward"],
                               correctAnswer: 1,
                               explanation: "Gas refers to the fees paid to execute transactions and smart contracts on Ethereum."),
                TriviaQuestion(question: "What is yield farming?",
                               answers: ["Growing crops", "Earning rewards by providing liquidity", "Mining cryptocurrency", "Trading tokens"],
                               correctAnswer: 1,
                               explanation: "Yield farming involves earning rewards by providing liquidity to DeFi protocols."),
                TriviaQuestion(question: "What is a DEX?",
                               answers: ["Decentralized Exchange", "Digital Exchange", "Direct Exchange", "Dynamic Exchange"],
                               correctAnswer: 0,
                               explanation: "A DEX is a Decentralized Exchange that allows peer-to-peer trading without intermediaries."),
                TriviaQuestion(question: "What is staking?",
                               answers: ["A type of mining", "Locking crypto to earn rewards", "A trading strategy", "A security measure"],
                               correctAnswer: 1,
                               explanation: "Staking involves locking cryptocurrency to help secure the network and earn rewards."),
                TriviaQuestion(question: "What is an ICO?",
                               answers: ["Initial Coin Offering", "International Crypto Organization", "Investment Crypto Option", "Initial Crypto Order"],
                               correctAnswer: 0,
                               explanation: "An ICO is an Initial Coin Offering where new cryptocurrencies are sold to raise funds."),
                TriviaQuestion(question: "What is a token?",
                               answers: ["A physical coin", "A digital asset on a blockchain", "A type of wallet", "A mining reward"],
                               correctAnswer: 1,
                               explanation: "A token is a digital asset that exists on an existing blockchain platform.")
            ]
        ),
        TriviaChapter(
            title: "Crypto History & Milestones",
            questions: [
                TriviaQuestion(question: "When was Bitcoin created?",
                               answers: ["2008", "2009", "2010", "2011"],
                               correctAnswer: 0,
                               explanation: "Bitcoin was created in 2008 with the publication of the Bitcoin whitepaper."),
                TriviaQuestion(question: "What was the first real-world Bitcoin transaction?",
                               answers: ["Buying a car", "Buying pizza", "Buying a house", "Buying gold"],
                               correctAnswer: 1,
                               explanation: "The first real-world Bitcoin transaction was buying two pizzas for 10,000 BTC in 2010."),
                TriviaQuestion(question: "What is the Bitcoin whitepaper called?",
                               answers: ["Bitcoin: A Digital Currency", "Bitcoin: A Peer-to-Peer Electronic Cash System", "Bitcoin: The Future of Money", "Bitcoin: Digital Gold"],
                               correctAnswer: 1,
                               explanation: "The Bitcoin whitepaper is titled 'Bitcoin: A Peer-to-Peer Electronic Cash System'."),
                TriviaQuestion(question: "When did Ethereum launch?",
                               answers: ["2013", "2014", "2015", "2016"],
                               correctAnswer: 2,
                               explanation: "Ethereum launched in 2015 with its Genesis block."),
                TriviaQuestion(question: "What was the first major Bitcoin exchange?",
                               answers: ["Coinbase", "Mt. Gox", "Binance", "Kraken"],
                               correctAnswer: 1,
                               explanation: "Mt. Gox was the first major Bitcoin exchange, launched in 2010."),
                TriviaQuestion(question: "What is the 'Crypto Winter'?",
                               answers: ["A season", "A period of low crypto prices", "A type of mining", "A security feature"],
                               correctAnswer: 1,
                               explanation: "Crypto Winter refers to extended periods of declining cryptocurrency prices."),
                TriviaQuestion(question: "When was the first Bitcoin halving?",
                               answers: ["2010", "2012", "2014", "2016"],
                               correctAnswer: 1,
                               explanation: "The first Bitcoin halving occurred in 2012, reducing the block reward from 50 to 25 BTC."),
                TriviaQuestion(question: "What is the 'Genesis Block'?",
                               answers: ["The first block", "A type of mining", "A wallet feature", "A trading pair"],
                               correctAnswer: 0,
                               explanation: "The Genesis Block is the first block ever created in a blockchain."),
                TriviaQuestion(question: "What was the first altcoin?",
                               answers: ["Ethereum", "Litecoin", "Namecoin", "Dogecoin"],
                               correctAnswer: 2,
                               explanation: "Namecoin was the first altcoin, created in 2011 as a decentralized domain name system."),
                TriviaQuestion(question: "What is the 'Pizza Day' in crypto?",
                               answers: ["Bitcoin's birthday", "The day Bitcoin was worth $1", "The day of the first Bitcoin pizza purchase", "A trading holiday"],
                               correctAnswer: 2,
                               explanation: "Pizza Day commemorates the first real-world Bitcoin transaction where 10,000 BTC was spent on pizza.")
            ]
        ),
        TriviaChapter(
            title: "Crypto Security & Safety",
            questions: [
                TriviaQuestion(question: "What is a hardware wallet?",
                               answers: ["A physical device", "A software app", "A type of exchange", "A mining rig"],
                               correctAnswer: 0,
                               explanation: "A hardware wallet is a physical device that stores private keys offline for enhanced security."),
                TriviaQuestion(question: "What is 2FA?",
                               answers: ["Two Factor Authentication", "Two File Access", "Two Function App", "Two Form Account"],
                               correctAnswer: 0,
                               explanation: "2FA is Two Factor Authentication, adding an extra layer of security to your accounts."),
                TriviaQuestion(question: "What is a seed phrase?",
                               answers: ["A password", "A recovery phrase", "A public address", "A trading pair"],
                               correctAnswer: 1,
                               explanation: "A seed phrase is a series of words used to recover and restore your cryptocurrency wallet."),
                TriviaQuestion(question: "What is a hot wallet?",
                               answers: ["A wallet that's always online", "A hardware wallet", "A cold wallet", "A paper wallet"],
                               correctAnswer: 0,
                               explanation: "A hot wallet is connected to the internet and is more convenient but less secure."),
                TriviaQuestion(question: "What is a cold wallet?",
                               answers: ["A wallet kept offline", "A hardware wallet", "A software wallet", "A paper wallet"],
                               correctAnswer: 0,
                               explanation: "A cold wallet is kept offline for maximum security."),
                TriviaQuestion(question: "What is phishing in crypto?",
                               answers: ["A type of mining", "A scam to steal private keys", "A trading strategy", "A security feature"],
                               correctAnswer: 1,
                               explanation: "Phishing is a scam where attackers try to steal private keys or passwords through fake websites."),
                TriviaQuestion(question: "What is a paper wallet?",
                               answers: ["A physical paper", "A software wallet", "A hardware wallet", "A type of exchange"],
                               correctAnswer: 0,
                               explanation: "A paper wallet is a physical piece of paper with private keys printed on it."),
                TriviaQuestion(question: "What is a dusting attack?",
                               answers: ["A type of mining", "A security attack", "A trading strategy", "A wallet feature"],
                               correctAnswer: 1,
                               explanation: "A dusting attack sends small amounts of cryptocurrency to track wallet activity."),
                TriviaQuestion(question: "What is a rug pull?",
                               answers: ["A type of mining", "A scam where developers abandon a project", "A trading strategy", "A security feature"],
                               correctAnswer: 1,
                               explanation: "A rug pull is when developers abandon a project and steal investors' funds."),
                TriviaQuestion(question: "What is a multi-signature wallet?",
                               answers: ["A wallet with multiple addresses", "A wallet requiring multiple signatures", "A type of exchange", "A hardware wallet"],
                               correctAnswer: 1,
                               explanation: "A multi-signature wallet requires multiple private keys to authorize transactions.")
            ]
        ),
        TriviaChapter(
            title: "NFTs & Digital Assets",
            questions: [
                TriviaQuestion(question: "What does NFT stand for?",
                               answers: ["Non-Fungible Token", "New Financial Technology", "Network File Transfer", "No Fee Transaction"],
                               correctAnswer: 0,
                               explanation: "NFT stands for Non-Fungible Token, meaning each token is unique and not interchangeable."),
                TriviaQuestion(question: "What makes an NFT unique?",
                               answers: ["Its price", "Its blockchain", "Its metadata", "Its color"],
                               correctAnswer: 2,
                               explanation: "An NFT's uniqueness comes from its metadata, which contains information about the digital asset."),
                TriviaQuestion(question: "What is minting an NFT?",
                               answers: ["Buying an NFT", "Creating an NFT", "Selling an NFT", "Storing an NFT"],
                               correctAnswer: 1,
                               explanation: "Minting is the process of creating a new NFT and adding it to the blockchain."),
                TriviaQuestion(question: "What is the most expensive NFT ever sold?",
                               answers: ["CryptoPunk", "Bored Ape", "Everydays: The First 5000 Days", "Doge"],
                               correctAnswer: 2,
                               explanation: "Everydays: The First 5000 Days by Beeple sold for $69 million in 2021."),
                TriviaQuestion(question: "What is a CryptoPunk?",
                               answers: ["A type of cryptocurrency", "A popular NFT collection", "A trading strategy", "A wallet feature"],
                               correctAnswer: 1,
                               explanation: "CryptoPunks are one of the first and most valuable NFT collections, created in 2017."),
                TriviaQuestion(question: "What is metadata in NFTs?",
                               answers: ["The price", "The blockchain", "The descriptive information", "The wallet address"],
                               correctAnswer: 2,
                               explanation: "Metadata contains descriptive information about the NFT, such as name, description, and attributes."),
                TriviaQuestion(question: "What is a floor price?",
                               answers: ["The lowest price", "The highest price", "The average price", "The minting price"],
                               correctAnswer: 0,
                               explanation: "The floor price is the lowest price at which an NFT from a collection is currently listed for sale."),
                TriviaQuestion(question: "What is gas in NFT transactions?",
                               answers: ["A fuel", "Transaction fees", "A type of NFT", "A trading pair"],
                               correctAnswer: 1,
                               explanation: "Gas refers to the fees paid to execute NFT transactions on the blockchain."),
                TriviaQuestion(question: "What is a generative NFT?",
                               answers: ["An NFT that moves", "An NFT created by algorithm", "An expensive NFT", "A rare NFT"],
                               correctAnswer: 1,
                               explanation: "A generative NFT is created using algorithms that combine different traits to create unique variations."),
                TriviaQuestion(question: "What is rarity in NFTs?",
                               answers: ["How expensive it is", "How unique the traits are", "How old it is", "How popular it is"],
                               correctAnswer: 1,
                               explanation: "Rarity refers to how unique or uncommon the traits of an NFT are within its collection.")
            ]
        ),
        TriviaChapter(
            title: "Crypto Trading & Markets",
            questions: [
                TriviaQuestion(question: "What is a bull market?",
                               answers: ["A market with rising prices", "A market with falling prices", "A sideways market", "A volatile market"],
                               correctAnswer: 0,
                               explanation: "A bull market is characterized by rising prices and optimistic investor sentiment."),
                TriviaQuestion(question: "What is a bear market?",
                               answers: ["A market with rising prices", "A market with falling prices", "A sideways market", "A volatile market"],
                               correctAnswer: 1,
                               explanation: "A bear market is characterized by falling prices and pessimistic investor sentiment."),
                TriviaQuestion(question: "What is leverage in trading?",
                               answers: ["Borrowing funds to trade", "Trading without fees", "Trading only with your own money", "A type of order"],
                               correctAnswer: 0,
                               explanation: "Leverage means borrowing funds to increase your trading position size."),
                TriviaQuestion(question: "What is a stop-loss order?",
                               answers: ["An order to buy at a lower price", "An order to sell if price drops to a certain level", "An order to buy at a higher price", "A market order"],
                               correctAnswer: 1,
                               explanation: "A stop-loss order automatically sells your asset if the price drops to a certain level to limit losses."),
                TriviaQuestion(question: "What is FOMO?",
                               answers: ["Fear of Missing Out", "Fear of Market Overload", "Fast Order Market Option", "Fundamental Order Market"],
                               correctAnswer: 0,
                               explanation: "FOMO stands for Fear of Missing Out, a common emotion that drives people to buy when prices are rising."),
                TriviaQuestion(question: "What is HODL?",
                               answers: ["Hold On for Dear Life", "Hold", "High Order Daily Limit", "Hold Order"],
                               correctAnswer: 0,
                               explanation: "HODL stands for 'Hold On for Dear Life,' a strategy of holding cryptocurrency long-term."),
                TriviaQuestion(question: "What is market cap?",
                               answers: ["The total value", "The price per coin", "The trading volume", "The number of coins"],
                               correctAnswer: 0,
                               explanation: "Market cap is the total value of all coins in circulation, calculated by price × circulating supply."),
                TriviaQuestion(question: "What is volume in trading?",
                               answers: ["The price", "The amount traded", "The market cap", "The number of traders"],
                               correctAnswer: 1,
                               explanation: "Volume refers to the total amount of cryptocurrency traded in a given time period."),
                TriviaQuestion(question: "What is a limit order?",
                               answers: ["An order to buy/sell at market price", "An order to buy/sell at a specific price", "A stop-loss order", "A market order"],
                               correctAnswer: 1,
                               explanation: "A limit order allows you to buy or sell at a specific price or better."),
                TriviaQuestion(question: "What is a market order?",
                               answers: ["An order to buy/sell immediately", "An order at a specific price", "A stop-loss order", "A limit order"],
                               correctAnswer: 0,
                               explanation: "A market order executes immediately at the current market price.")
            ]
        ),
        TriviaChapter(
            title: "Altcoins & Blockchain Tech",
            questions: [
                TriviaQuestion(question: "Which coin is known as 'Ethereum Killer'?",
                               answers: ["Cardano", "Dogecoin", "Tether", "Litecoin"],
                               correctAnswer: 0,
                               explanation: "Cardano is often called an 'Ethereum Killer' due to its smart contract capabilities and proof-of-stake consensus."),
                TriviaQuestion(question: "What is a smart contract?",
                               answers: ["A legal contract", "Self-executing code on blockchain", "A contract for smart devices", "A trading agreement"],
                               correctAnswer: 1,
                               explanation: "A smart contract is self-executing code that runs on the blockchain when predetermined conditions are met."),
                TriviaQuestion(question: "Which blockchain uses proof-of-stake?",
                               answers: ["Ethereum 2.0", "Bitcoin", "Dogecoin", "Litecoin"],
                               correctAnswer: 0,
                               explanation: "Ethereum 2.0 uses proof-of-stake for consensus, which is more energy-efficient than proof-of-work."),
                TriviaQuestion(question: "What is sharding in blockchain?",
                               answers: ["A type of mining", "A scaling technique", "A privacy feature", "A security measure"],
                               correctAnswer: 1,
                               explanation: "Sharding is a scaling technique that splits the blockchain into smaller parts to process more transactions."),
                TriviaQuestion(question: "Which blockchain is focused on privacy?",
                               answers: ["Monero", "Litecoin", "Ripple", "Cardano"],
                               correctAnswer: 0,
                               explanation: "Monero is a privacy-focused blockchain that obscures transaction details."),
                TriviaQuestion(question: "What is a stablecoin?",
                               answers: ["A coin with stable mining", "A cryptocurrency pegged to a stable asset", "A type of wallet", "A trading strategy"],
                               correctAnswer: 1,
                               explanation: "A stablecoin is a cryptocurrency designed to maintain a stable value, often pegged to fiat currencies."),
                TriviaQuestion(question: "What is a fork in blockchain?",
                               answers: ["A type of mining", "A split in the blockchain", "A security feature", "A trading pair"],
                               correctAnswer: 1,
                               explanation: "A fork occurs when a blockchain splits into two separate chains, often due to disagreements in the community."),
                TriviaQuestion(question: "What is a memecoin?",
                               answers: ["A serious cryptocurrency", "A joke-based cryptocurrency", "A stablecoin", "A privacy coin"],
                               correctAnswer: 1,
                               explanation: "A memecoin is a cryptocurrency created as a joke or based on internet memes."),
                TriviaQuestion(question: "What is a layer 2 solution?",
                               answers: ["A second blockchain", "A scaling solution built on top of a blockchain", "A type of wallet", "A security feature"],
                               correctAnswer: 1,
                               explanation: "Layer 2 solutions are built on top of existing blockchains to improve scalability and reduce fees."),
                TriviaQuestion(question: "What is cross-chain technology?",
                               answers: ["A type of mining", "Technology that connects different blockchains", "A security feature", "A trading strategy"],
                               correctAnswer: 1,
                               explanation: "Cross-chain technology allows different blockchains to communicate and transfer assets between each other.")
            ]
        ),
        TriviaChapter(
            title: "Crypto Regulations",
            questions: [
                TriviaQuestion(question: "What is KYC?",
                               answers: ["Know Your Customer", "Keep Your Crypto", "Know Your Coin", "Keep Your Cash"],
                               correctAnswer: 0,
                               explanation: "KYC stands for Know Your Customer, a process to verify customer identity for regulatory compliance."),
                TriviaQuestion(question: "What is AML?",
                               answers: ["Anti-Money Laundering", "All My Loot", "Automated Market Logic", "Advanced Mining Layer"],
                               correctAnswer: 0,
                               explanation: "AML stands for Anti-Money Laundering, regulations to prevent illegal financial activities."),
                TriviaQuestion(question: "Which country was first to make Bitcoin legal tender?",
                               answers: ["USA", "Japan", "El Salvador", "Switzerland"],
                               correctAnswer: 2,
                               explanation: "El Salvador became the first country to make Bitcoin legal tender in 2021."),
                TriviaQuestion(question: "What is a CBDC?",
                               answers: ["Central Bank Digital Currency", "Crypto Based Digital Coin", "Central Blockchain Digital Currency", "Crypto Bank Digital Currency"],
                               correctAnswer: 0,
                               explanation: "A CBDC is a Central Bank Digital Currency, a digital form of a country's fiat currency."),
                TriviaQuestion(question: "What is the SEC?",
                               answers: ["Securities and Exchange Commission", "Security and Encryption Council", "Smart Exchange Commission", "System and Exchange Control"],
                               correctAnswer: 0,
                               explanation: "The SEC is the Securities and Exchange Commission, which regulates securities in the United States."),
                TriviaQuestion(question: "What is institutional adoption?",
                               answers: ["Banks buying crypto", "Large companies and institutions using crypto", "Individual investors buying crypto", "Governments regulating crypto"],
                               correctAnswer: 1,
                               explanation: "Institutional adoption refers to large companies and financial institutions adopting cryptocurrency."),
                TriviaQuestion(question: "What is a crypto ETF?",
                               answers: ["Exchange Traded Fund", "Electronic Trading Fund", "Encrypted Trading Fund", "Exchange Token Fund"],
                               correctAnswer: 0,
                               explanation: "A crypto ETF is an Exchange Traded Fund that tracks cryptocurrency prices."),
                TriviaQuestion(question: "What is DeFi regulation?",
                               answers: ["Rules for DeFi", "A type of DeFi", "A DeFi protocol", "A DeFi token"],
                               correctAnswer: 0,
                               explanation: "DeFi regulation refers to rules and guidelines for decentralized finance protocols."),
                TriviaQuestion(question: "What is a crypto tax?",
                               answers: ["A tax on crypto", "A type of crypto", "A trading fee", "A mining reward"],
                               correctAnswer: 0,
                               explanation: "Crypto tax refers to taxes on cryptocurrency transactions and gains."),
                TriviaQuestion(question: "What is regulatory clarity?",
                               answers: ["Clear regulations", "A type of crypto", "A trading strategy", "A security feature"],
                               correctAnswer: 0,
                               explanation: "Regulatory clarity refers to clear and consistent rules for cryptocurrency operations.")
            ]
        ),
        TriviaChapter(
            title: "Crypto Wallets & Storage",
            questions: [
                TriviaQuestion(question: "What is a wallet address?",
                               answers: ["Your home address", "A shareable crypto address", "A private key", "A wallet name"],
                               correctAnswer: 1,
                               explanation: "A wallet address is a shareable address where others can send you cryptocurrency."),
                TriviaQuestion(question: "What is a seed phrase?",
                               answers: ["A password", "A recovery phrase", "A public address", "A trading pair"],
                               correctAnswer: 1,
                               explanation: "A seed phrase is a series of words used to recover and restore your cryptocurrency wallet."),
                TriviaQuestion(question: "What is a hot wallet?",
                               answers: ["A wallet that's always online", "A hardware wallet", "A cold wallet", "A paper wallet"],
                               correctAnswer: 0,
                               explanation: "A hot wallet is connected to the internet and is more convenient but less secure."),
                TriviaQuestion(question: "What is a cold wallet?",
                               answers: ["A wallet kept offline", "A hardware wallet", "A software wallet", "A paper wallet"],
                               correctAnswer: 0,
                               explanation: "A cold wallet is kept offline for maximum security."),
                TriviaQuestion(question: "What is a hardware wallet?",
                               answers: ["A physical device", "A software app", "A type of exchange", "A mining rig"],
                               correctAnswer: 0,
                               explanation: "A hardware wallet is a physical device that stores private keys offline for enhanced security."),
                TriviaQuestion(question: "What is a software wallet?",
                               answers: ["A physical device", "A digital application", "A type of exchange", "A mining rig"],
                               correctAnswer: 1,
                               explanation: "A software wallet is a digital application that stores your cryptocurrency."),
                TriviaQuestion(question: "What is a paper wallet?",
                               answers: ["A physical paper", "A software wallet", "A hardware wallet", "A type of exchange"],
                               correctAnswer: 0,
                               explanation: "A paper wallet is a physical piece of paper with private keys printed on it."),
                TriviaQuestion(question: "What is a multi-signature wallet?",
                               answers: ["A wallet with multiple addresses", "A wallet requiring multiple signatures", "A type of exchange", "A hardware wallet"],
                               correctAnswer: 1,
                               explanation: "A multi-signature wallet requires multiple private keys to authorize transactions."),
                TriviaQuestion(question: "What is a custodial wallet?",
                               answers: ["A wallet you control", "A wallet controlled by a third party", "A hardware wallet", "A paper wallet"],
                               correctAnswer: 1,
                               explanation: "A custodial wallet is controlled by a third party, like an exchange."),
                TriviaQuestion(question: "What is a non-custodial wallet?",
                               answers: ["A wallet you control", "A wallet controlled by a third party", "A hardware wallet", "A paper wallet"],
                               correctAnswer: 0,
                               explanation: "A non-custodial wallet gives you full control over your private keys and funds.")
            ]
        )
    ]
    
    @State private var currentChapterIndex: Int? = nil // nil means landing page
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswerIndex: Int? = nil
    @State private var isAnswerSubmitted = false
    @State private var isCorrectAnswer = false
    @State private var isQuizCompleted = false
    @State private var feedbackMessage: String = ""
    @State private var currentScore = 0
    @State private var highScore = UserDefaults.standard.integer(forKey: "HighScore")
    @EnvironmentObject private var store: Store
    @EnvironmentObject private var interstitialAdManager: InterstitialAdManager
    @State private var hasShownInterstitialThisCompletion = false
    
    // Chapter progress tracking
    @State private var completedChapters: [Int] = []
    @State private var chapterScores: [Int: Int] = [:]
    
    private let accentGradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0.13, green: 0.82, blue: 0.67), Color(red: 0.98, green: 0.45, blue: 0.2)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    var body: some View {
        if currentChapterIndex == nil {
            landingPage
        } else {
            quizView
        }
    }
    
    var landingPage: some View {
        ZStack {
            triviaBackground
            ScrollView {
                VStack(spacing: 28) {
                    VStack(spacing: 14) {
                        ZStack {
                            Circle()
                                .fill(accentGradient.opacity(0.25))
                                .frame(width: 92, height: 92)
                            Image(systemName: "bitcoinsign.circle.fill")
                                .font(.system(size: 56, weight: .bold))
                                .foregroundStyle(accentGradient)
                        }
                        
                        Text("Crypto Trivia")
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .foregroundStyle(.primary)
                        
                        Text("Short, sharp questions that sharpen your crypto IQ.")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 28)
                    }
                    .padding(.top, 12)
                    
                    HStack(spacing: 12) {
                        statCard(title: "High Score", value: "\(highScore)")
                        statCard(title: "Chapters", value: "\(completedChapters.count)/\(chapters.count)")
                    }
                    .padding(.horizontal, 16)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(0..<chapters.count, id: \.self) { idx in
                            ChapterCard(
                                chapter: chapters[idx],
                                isCompleted: completedChapters.contains(idx),
                                score: chapterScores[idx] ?? 0,
                                totalQuestions: chapters[idx].questions.count
                            ) {
                                startChapter(idx)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 24)
            }
        }
        .onAppear { loadProgressData() }
    }
    
    private func loadProgressData() {
        // Load completed chapters
        if let data = UserDefaults.standard.data(forKey: "completedChapters"),
           let chapters = try? JSONDecoder().decode([Int].self, from: data) {
            completedChapters = chapters
        }
        
        // Load chapter scores
        if let data = UserDefaults.standard.data(forKey: "chapterScores"),
           let scores = try? JSONDecoder().decode([Int: Int].self, from: data) {
            chapterScores = scores
        }
    }
    
    private func saveProgressData() {
        // Save completed chapters
        if let data = try? JSONEncoder().encode(completedChapters) {
            UserDefaults.standard.set(data, forKey: "completedChapters")
        }
        
        // Save chapter scores
        if let data = try? JSONEncoder().encode(chapterScores) {
            UserDefaults.standard.set(data, forKey: "chapterScores")
        }
    }
    
    private func startChapter(_ chapterIndex: Int) {
        currentChapterIndex = chapterIndex
        currentQuestionIndex = 0
        selectedAnswerIndex = nil
        isAnswerSubmitted = false
        isCorrectAnswer = false
        isQuizCompleted = false
        currentScore = 0
        feedbackMessage = ""
        hasShownInterstitialThisCompletion = false
    }
    
    var quizView: some View {
        ZStack {
            triviaBackground
            
            ScrollView {
                VStack(spacing: 18) {
                    HStack(spacing: 12) {
                        Button(action: { currentChapterIndex = nil }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.primary)
                                .padding(10)
                                .background(.ultraThinMaterial, in: Circle())
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Trivia")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.secondary)
                            if let chapterIdx = currentChapterIndex {
                                Text(chapters[chapterIdx].title)
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(.primary)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    
                    if let chapterIdx = currentChapterIndex {
                        let currentChapter = chapters[chapterIdx]
                        VStack(spacing: 8) {
                            HStack {
                                Text("Question \(currentQuestionIndex + 1) of \(currentChapter.questions.count)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("Score \(currentScore)")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(accentGradient)
                            }
                            ProgressView(value: Double(currentQuestionIndex + 1), total: Double(currentChapter.questions.count))
                                .tint(accentGradient)
                        }
                        .padding(16)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal, 16)
                        .animation(.easeInOut, value: currentQuestionIndex)
                    }
                    
                    if !isQuizCompleted, let chapterIdx = currentChapterIndex {
                        let currentChapter = chapters[chapterIdx]
                        let currentQuestion = currentChapter.questions[currentQuestionIndex]
                        
                        VStack(spacing: 24) {
                            Text(currentQuestion.question)
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 8)
                        }
                        .padding(24)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(.systemBackground).opacity(0.9))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
                                )
                                .shadow(color: Color.black.opacity(0.12), radius: 20, x: 0, y: 10)
                        )
                        .padding(.horizontal, 16)
                        .padding(.bottom, 24)
                        
                        VStack(spacing: 12) {
                            ForEach(0..<currentQuestion.answers.count, id: \.self) { index in
                                Button(action: {
                                    if !isAnswerSubmitted {
                                        selectedAnswerIndex = index
                                    }
                                    let impactHeavy = UIImpactFeedbackGenerator(style: .medium)
                                    impactHeavy.impactOccurred()
                                }) {
                                    HStack {
                                        Text(currentQuestion.answers[index])
                                            .font(.system(size: 17, weight: .semibold))
                                            .foregroundColor(.primary)
                                        Spacer()
                                        if isAnswerSubmitted && index == selectedAnswerIndex {
                                            Image(systemName: isCorrectAnswer ? "checkmark.circle.fill" : "xmark.circle.fill")
                                                .foregroundColor(isCorrectAnswer ? .green : .red)
                                                .font(.title2)
                                        }
                                    }
                                    .padding(.vertical, 20)
                                    .padding(.horizontal, 24)
                                    .frame(maxWidth: .infinity)
                                    .background(duolingoAnswerBackground(index: index))
                                    .cornerRadius(16)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(duolingoAnswerStroke(index: index), lineWidth: 3)
                                    )
                                    .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 6)
                                }
                                .disabled(isAnswerSubmitted)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                        
                        if !isAnswerSubmitted {
                            Button(action: {
                                guard let selectedIndex = selectedAnswerIndex else { return }
                                submitAnswer(selectedIndex)
                            }) {
                                Text("Submit Answer")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color(.systemGray4))
                                            .opacity(selectedAnswerIndex == nil ? 1 : 0)
                                    )
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(accentGradient)
                                            .opacity(selectedAnswerIndex == nil ? 0 : 1)
                                    )
                                    .foregroundColor(.white)
                                    .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 6)
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 10)
                            .disabled(selectedAnswerIndex == nil)
                        } else {
                            // Feedback card
                            VStack(spacing: 16) {
                                HStack {
                                    Image(systemName: isCorrectAnswer ? "checkmark.circle.fill" : "xmark.circle.fill")
                                        .foregroundColor(isCorrectAnswer ? .green : .red)
                                        .font(.title)
                                    Text(isCorrectAnswer ? "Correct!" : "Incorrect")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(isCorrectAnswer ? .green : .red)
                                }
                                
                                Text(feedbackMessage)
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(20)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(isCorrectAnswer ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
                            )
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                            
                            Button(action: {
                                moveToNextQuestion()
                                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                impactHeavy.impactOccurred()
                            }) {
                                Text(nextButtonText())
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(accentGradient)
                                    .foregroundColor(.white)
                                    .cornerRadius(16)
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                        }
                        Spacer()
                    } else {
                        // Show interstitial ad after chapter completion (once per completion)
                        Color.clear
                            .frame(height: 0)
                            .onAppear {
                                if !hasShownInterstitialThisCompletion && !store.completedPurchases.contains("com.removeads.profitloss") {
                                    if interstitialAdManager.isAdReady {
                                        let rootVC = UIApplication.shared.getRootViewController()
                                        interstitialAdManager.showInterstitial(from: rootVC)
                                    }
                                    hasShownInterstitialThisCompletion = true
                                }
                            }
                        
                        // Completion screen
                        VStack(spacing: 24) {
                            Image(systemName: "trophy.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.yellow)
                            
                            Text("Chapter Complete!")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                            
                            Text("Score: \(currentScore)")
                                .font(.title2)
                                .foregroundStyle(accentGradient)
                            
                            if currentScore > highScore {
                                Text("New High Score!")
                                    .font(.headline)
                                    .foregroundColor(.green)
                            }
                            
                            Button(action: {
                                restartTrivia()
                                hasShownInterstitialThisCompletion = false
                            }) {
                                Text("Continue")
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(accentGradient)
                                    .foregroundColor(.white)
                                    .cornerRadius(16)
                            }
                            .padding(.horizontal, 16)
                        }
                        .padding()
                    }
                }
                .padding(.vertical, 12)
            }
        }
    }
    
    private var triviaBackground: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(.systemBackground), Color(.systemGray6)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            Circle()
                .fill(Color(red: 0.13, green: 0.82, blue: 0.67).opacity(0.12))
                .frame(width: 240, height: 240)
                .blur(radius: 10)
                .offset(x: -120, y: -160)
            
            Circle()
                .fill(Color(red: 0.98, green: 0.45, blue: 0.2).opacity(0.12))
                .frame(width: 280, height: 280)
                .blur(radius: 12)
                .offset(x: 130, y: 220)
        }
    }
    
    private func statCard(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
            Text(value)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(accentGradient)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14))
    }
    
    private func submitAnswer(_ selectedIndex: Int) {
        guard let chapterIdx = currentChapterIndex else { return }
        let currentChapter = chapters[chapterIdx]
        let currentQuestion = currentChapter.questions[currentQuestionIndex]
        
        isCorrectAnswer = selectedIndex == currentQuestion.correctAnswer
        isAnswerSubmitted = true
        feedbackMessage = currentQuestion.explanation
        
        if isCorrectAnswer {
            currentScore += 100
        }
        
        let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
        impactHeavy.impactOccurred()
    }
    
    private func duolingoAnswerBackground(index: Int) -> Color {
        guard let chapterIdx = currentChapterIndex else { return Color(.systemGray6) }
        let currentChapter = chapters[chapterIdx]
        let currentQuestion = currentChapter.questions[currentQuestionIndex]
        
        if isAnswerSubmitted {
            if index == selectedAnswerIndex {
                return isCorrectAnswer ? Color.green.opacity(0.2) : Color.red.opacity(0.2)
            } else if index == currentQuestion.correctAnswer {
                return Color.green.opacity(0.2)
            }
        } else if index == selectedAnswerIndex {
            return Color.green.opacity(0.1) // Changed from blue to green
        }
        return Color(.systemGray6)
    }
    
    private func duolingoAnswerStroke(index: Int) -> Color {
        guard let chapterIdx = currentChapterIndex else { return Color.clear }
        let currentChapter = chapters[chapterIdx]
        let currentQuestion = currentChapter.questions[currentQuestionIndex]
        
        if isAnswerSubmitted {
            if index == selectedAnswerIndex {
                return isCorrectAnswer ? .green : .red
            } else if index == currentQuestion.correctAnswer {
                return .green
            }
        } else if index == selectedAnswerIndex {
            return .green // Changed from blue to green
        }
        return .clear
    }
    
    private func moveToNextQuestion() {
        selectedAnswerIndex = nil
        isAnswerSubmitted = false
        isCorrectAnswer = false
        feedbackMessage = ""
        guard let chapterIdx = currentChapterIndex else { return }
        let currentChapter = chapters[chapterIdx]
        if currentQuestionIndex < currentChapter.questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            isQuizCompleted = true
            checkHighScore()
            saveChapterProgress()
        }
    }
    
    private func saveChapterProgress() {
        guard let chapterIdx = currentChapterIndex else { return }
        
        // Mark chapter as completed
        if !completedChapters.contains(chapterIdx) {
            completedChapters.append(chapterIdx)
        }
        
        // Save score
        chapterScores[chapterIdx] = currentScore
        
        // Save to UserDefaults
        saveProgressData()
    }
    
    private func nextButtonText() -> String {
        guard let chapterIdx = currentChapterIndex else { return "Next" }
        let currentChapter = chapters[chapterIdx]
        if currentQuestionIndex < currentChapter.questions.count - 1 {
            return "Next Question"
        } else {
            return "Finish Chapter"
        }
    }
    
    private func checkHighScore() {
        if currentScore > highScore {
            highScore = currentScore
            UserDefaults.standard.set(highScore, forKey: "HighScore")
        }
    }
    
    private func restartTrivia() {
        currentChapterIndex = nil
        currentQuestionIndex = 0
        selectedAnswerIndex = nil
        isAnswerSubmitted = false
        isCorrectAnswer = false
        isQuizCompleted = false
        currentScore = 0
        feedbackMessage = ""
    }
}

// Chapter Card Component
struct ChapterCard: View {
    let chapter: CryptoTriviaView.TriviaChapter
    let isCompleted: Bool
    let score: Int
    let totalQuestions: Int
    let action: () -> Void
    
    private func chapterColor() -> Color {
        // Different colors for each chapter
        switch chapter.title {
        case "Bitcoin & Blockchain Basics":
            return Color(red: 0.98, green: 0.62, blue: 0.2)
        case "Ethereum, DeFi & More":
            return Color(red: 0.25, green: 0.55, blue: 0.95)
        case "Crypto History & Milestones":
            return Color(red: 0.62, green: 0.35, blue: 0.95)
        case "Crypto Security & Safety":
            return Color(red: 0.95, green: 0.35, blue: 0.42)
        case "NFTs & Digital Assets":
            return Color(red: 0.95, green: 0.4, blue: 0.75)
        case "Crypto Trading & Markets":
            return Color(red: 0.2, green: 0.75, blue: 0.45)
        case "Altcoins & Blockchain Tech":
            return Color(red: 0.2, green: 0.45, blue: 0.9)
        default:
            return .gray
        }
    }
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(chapter.title)
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                        
                        Text(isCompleted ? "Score \(score)" : "\(totalQuestions) questions")
                            .font(.subheadline)
                            .foregroundColor(isCompleted ? chapterColor() : .secondary)
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                    
                    Image(systemName: isCompleted ? "checkmark.seal.fill" : "sparkles")
                        .foregroundColor(chapterColor())
                        .font(.title3)
                }
                
                if isCompleted {
                    ProgressView(value: Double(score), total: Double(totalQuestions * 100))
                        .tint(chapterColor())
                        .scaleEffect(x: 1, y: 0.8, anchor: .center)
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground).opacity(0.9))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(chapterColor().opacity(0.3), lineWidth: 2)
                    )
                    .shadow(color: chapterColor().opacity(0.18), radius: 12, x: 0, y: 6)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
