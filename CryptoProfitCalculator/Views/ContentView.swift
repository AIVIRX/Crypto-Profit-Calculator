//
//  ContentView.swift
//  CryptoProfitCalculator
//
//  Created by Maicol Cabreja on 11/11/23.

import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

func symbolIcon(for symbol: String) -> String {
    switch symbol {
    case "$": return "dollarsign"
    case "€": return "eurosign"
    case "¥": return "yensign"
    case "£": return "sterlingsign"
    case "₽": return "rublesign"
    case "₹": return "indianrupeesign"
    case "₩": return "wonsign"
    default: return ""
    }
}

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var interstitialAdManager: InterstitialAdManager
    @EnvironmentObject private var store: Store
    @EnvironmentObject private var paywallState: PaywallState
    @State private var selectedTab: Tabs = .home
    
    enum Tabs: Hashable {
            case home
            case trivia
            case settings
        }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CalculatorView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(Tabs.home)

            CryptoTriviaView()
                .tabItem {
                    Label("Trivia", systemImage: "trophy.fill")
                }
                .tag(Tabs.trivia)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(Tabs.settings)
        }
        .accentColor(colorScheme == .dark ? .white : .black)
        .onAppear {
            // Track navigation for smart ads
            if !store.completedPurchases.contains("com.removeads.profitloss") {
                interstitialAdManager.recordNavigation()
                
                // Show ad if conditions are met
                if interstitialAdManager.shouldShowAdAfterNavigation() {
                    let rootVC = UIApplication.shared.getRootViewController()
                    interstitialAdManager.showSmartInterstitial(from: rootVC)
                }
            }
        }
    }
}


struct CalculatorView: View {
    let currencySymbols = ["$", "€", "¥", "£", "₽", "₹", "₩"]
    let currencyKey = "selectedCurrency"
    @AppStorage("selectedCurrency") private var selectedCurrency: String = "$"
    @EnvironmentObject private var store: Store
    @EnvironmentObject private var interstitialAdManager: InterstitialAdManager
    @EnvironmentObject private var paywallState: PaywallState
    @Environment(\.requestReview) private var requestReview
    @State private var sessionStart = Date()
    @State private var hasPromptedForReview = false
    @State private var hasShownInterstitialThisSession = false
    @State private var hasAttemptedFirstInterstitial = false
    @State private var hasRetriedFirstInterstitial = false
    @State private var investmentAmount = ""
    @State private var buyPrice = ""
    @State private var sellPrice = ""
    @State private var exitFeeAmount = ""
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView{
                    ProfitLossCard(
                        investmentAmount: emptyToZero(investmentAmount),
                        buyPrice: emptyToZero(buyPrice),
                        sellPrice: emptyToZero(sellPrice),
                        exitFeeAmount: emptyToZero(exitFeeAmount),
                        selectedCurrency: selectedCurrency
                    )
                    
                    CurrencyTextField(placeholder: "Investment", text: $investmentAmount, selectedCurrency: selectedCurrency)
                    CurrencyTextField(placeholder: "Buy Price", text: $buyPrice, selectedCurrency: selectedCurrency)
                    CurrencyTextField(placeholder: "Sell Price", text: $sellPrice, selectedCurrency: selectedCurrency)
                    CurrencyTextField(placeholder: "Exit Fee", text: $exitFeeAmount, selectedCurrency: selectedCurrency)
                    
                    // Go Ad-Free Button
                    if store.completedPurchases.contains("com.removeads.profitloss") == false {
                        Button(action: {
                            paywallState.isPresented = true
                        }) {
                            HStack {
                                Image(systemName: "crown.fill")
                                    .foregroundColor(.yellow)
                                Text("Go Ad-Free")
                                    .fontWeight(.bold)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.indigo.opacity(0.1))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.indigo.opacity(0.3), lineWidth: 1)
                                    )
                            )
                            .foregroundColor(.primary)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal)
                        .padding(.top, 8)
                    }
                }
            }
            .padding(5)
            .navigationBarTitle("Crypto Profit Calculator")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Picker("Currency", selection: $selectedCurrency) {
                        ForEach(currencySymbols, id: \.self) { symbol in
                            Image(systemName: symbolIcon(for: symbol))
                                .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 20 : 18))
                                .tag(symbol)
                        }
                    }
                    .frame(width: 20, height: 20)
                    .contentShape(Capsule())
                    .pickerStyle(.menu)
                    .onChange(of: selectedCurrency) { _, newValue in
                        UserDefaults.standard.set(newValue, forKey: currencyKey)
                    }
                }
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear{
                store.loadStoredPurchases()
                sessionStart = Date()
                hasAttemptedFirstInterstitial = false
                hasRetriedFirstInterstitial = false
                hasShownInterstitialThisSession = false
            }
            .onChange(of: investmentAmount) { _, _ in
                maybeRequestReview()
            }
            .onChange(of: buyPrice) { _, _ in
                maybeRequestReview()
            }
            .onChange(of: sellPrice) { _, _ in
                maybeRequestReview()
            }
            .onChange(of: exitFeeAmount) { _, _ in
                maybeRequestReview()
            }
            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                if !hasPromptedForReview && Date().timeIntervalSince(sessionStart) > 45 {
                    maybeRequestReview()
                }

                let elapsed = Date().timeIntervalSince(sessionStart)

                // First attempt after 15 seconds
                if !hasAttemptedFirstInterstitial && elapsed > 15 {
                    hasAttemptedFirstInterstitial = true
                    if !store.completedPurchases.contains("com.removeads.profitloss"),
                       interstitialAdManager.shouldShowAd() {
                        let rootVC = UIApplication.shared.getRootViewController()
                        interstitialAdManager.showSmartInterstitial(from: rootVC)
                        hasShownInterstitialThisSession = true
                    }
                }

                // One retry after 25 seconds if not shown yet
                if !hasShownInterstitialThisSession && hasAttemptedFirstInterstitial && !hasRetriedFirstInterstitial && elapsed > 25 {
                    hasRetriedFirstInterstitial = true
                    if !store.completedPurchases.contains("com.removeads.profitloss"),
                       interstitialAdManager.shouldShowAd() {
                        let rootVC = UIApplication.shared.getRootViewController()
                        interstitialAdManager.showSmartInterstitial(from: rootVC)
                        hasShownInterstitialThisSession = true
                    }
                }
            }
        }
    }
        
        func maybeRequestReview() {
            let lastPromptDate = UserDefaults.standard.object(forKey: "LastReviewPromptDate") as? Date
            let now = Date()
            let minInterval: TimeInterval = 60 * 60 * 24 * 30 // 30 days
            
            if lastPromptDate == nil || now.timeIntervalSince(lastPromptDate!) > minInterval {
                requestReview()
                UserDefaults.standard.set(now, forKey: "LastReviewPromptDate")
                hasPromptedForReview = true
            }
        }
    }
    
    // Helper function to parse numbers with international decimal separators
    private func parseNumber(_ string: String) -> Double? {
        // Remove any currency symbols and trim whitespace
        let cleaned = string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Handle empty strings
        if cleaned.isEmpty {
            return 0.0
        }
        
        // First, try parsing with the user's locale
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        
        if let number = formatter.number(from: cleaned) {
            return number.doubleValue
        }
        
        // If that fails, try parsing with dot as decimal separator
        if let number = Double(cleaned) {
            return number
        }
        
        // If that fails, try replacing comma with dot and parsing
        let withDot = cleaned.replacingOccurrences(of: ",", with: ".")
        if let number = Double(withDot) {
            return number
        }
        
        // If that fails, try replacing dot with comma and parsing with locale
        let withComma = cleaned.replacingOccurrences(of: ".", with: ",")
        if let number = formatter.number(from: withComma) {
            return number.doubleValue
        }
        
        // Last resort: try to extract just the numeric parts
        let numericOnly = cleaned.components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
            .replacingOccurrences(of: ",", with: ".")
        
        return Double(numericOnly)
    }
    
    private func emptyToZero(_ value: String) -> String {
        if value == "Invalid Input" {
            return formatNumber(0.0)
        } else {
            return value.isEmpty ? formatNumber(0.0) : value
        }
    }
    
    // Helper function to format numbers using the user's locale
    private func formatNumber(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.current
        
        return formatter.string(from: NSNumber(value: number)) ?? "0.00"
    }
    
    struct ProfitLossCard: View {
        let investmentAmount: String
        let buyPrice: String
        let sellPrice: String
        let exitFeeAmount: String
        let selectedCurrency: String
        @State private var animatedProfitLoss: Double = 0.0
        
        var body: some View {
            let currentProfitLoss = calculateProfitLoss()
            let breakEvenSellPrice = calculateBreakEvenSellPrice()
            VStack(spacing: 5) {
                Text(formattedProfitLoss(from: animatedProfitLoss))
                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 50 : 40, weight: .black, design: .rounded))
                    .monospacedDigit()
                    .foregroundColor(textColor(for: currentProfitLoss))
                    .contentTransition(.numericText())

                Text(breakEvenText(from: breakEvenSellPrice))
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.white.opacity(0.9))
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: UIDevice.current.userInterfaceIdiom == .pad ? 128 : 112)
            .background(backgroundColor())
            .cornerRadius(cornerRadius())
            .onAppear {
                animatedProfitLoss = currentProfitLoss
            }
            .onChange(of: currentProfitLoss) { _, newValue in
                withAnimation(.snappy(duration: 0.35)) {
                    animatedProfitLoss = newValue
                }
            }
        }
        
        private func calculateProfitLoss() -> Double {
            guard let investment = parseNumber(investmentAmount),
                  let buyPrice = parseNumber(buyPrice),
                  let sell = parseNumber(sellPrice),
                  let exitFee = parseNumber(exitFeeAmount) else {
                return 0.0
            }
            
            // Protect against division by zero
            guard buyPrice > 0 else {
                return 0.0
            }
            
            let tokenAmount = investment / buyPrice
            let profitLoss = ((sell - buyPrice) * tokenAmount) - exitFee
            
            if profitLoss.isNaN || profitLoss.isInfinite {
                return 0.0
            }
            
            return profitLoss
        }

        private func calculateBreakEvenSellPrice() -> Double? {
            guard let investment = parseNumber(investmentAmount),
                  let buyPrice = parseNumber(buyPrice),
                  let exitFee = parseNumber(exitFeeAmount),
                  investment > 0,
                  buyPrice > 0 else {
                return nil
            }

            let tokenAmount = investment / buyPrice
            guard tokenAmount > 0 else {
                return nil
            }

            let breakEvenSellPrice = buyPrice + (exitFee / tokenAmount)
            guard breakEvenSellPrice.isFinite else {
                return nil
            }

            return breakEvenSellPrice
        }

        private func breakEvenText(from breakEvenSellPrice: Double?) -> String {
            guard let breakEvenSellPrice else {
                return "Break-even: 0.00"
            }

            return "Break-even: \(formattedCurrency(breakEvenSellPrice))"
        }
        
        private func formattedProfitLoss(from profitLoss: Double) -> String {
            var formattedProfitLoss = formattedCurrency(profitLoss)
            
            if profitLoss > 0 {
                formattedProfitLoss = "+\(formattedProfitLoss)"
            }
            
            return formattedProfitLoss
        }

        private func formattedCurrency(_ number: Double) -> String {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencySymbol = selectedCurrency
            formatter.locale = Locale.current
            return formatter.string(from: NSNumber(value: number)) ?? "\(selectedCurrency)0.00"
        }
        
        private func textColor(for profitLoss: Double) -> Color {
            if profitLoss == 0.0 {
                return .white
            } else {
                return profitLoss < 0 ? .red : .green
            }
        }
        
        private func backgroundColor() -> Color {
            return .indigo
        }
        
        private func cornerRadius() -> CGFloat {
            return 20
        }
    }
