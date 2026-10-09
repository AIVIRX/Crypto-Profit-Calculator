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
        .tint(tintColor)
    }

    private var tintColor: Color {
        return colorScheme == .dark ? .white : .black
    }
}


struct CalculatorView: View {
    let currencySymbols = ["$", "€", "¥", "£", "₽", "₹", "₩"]
    let currencyKey = "selectedCurrency"
    @AppStorage("selectedCurrency") private var selectedCurrency: String = "$"
    @EnvironmentObject private var store: Store
    @EnvironmentObject private var interstitialAdManager: InterstitialAdManager
    @EnvironmentObject private var paywallState: PaywallState
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var investmentAmount = ""
    @State private var buyPrice = ""
    @State private var sellPrice = ""
    @State private var exitFeeAmount = ""
    @State private var displayedInvestmentAmount = "0"
    @State private var displayedBuyPrice = "0"
    @State private var displayedSellPrice = "0"
    @State private var displayedExitFeeAmount = "0"

    private let calculationActionColor = Color.indigo

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ProfitLossCard(
                        investmentAmount: displayedInvestmentAmount,
                        buyPrice: displayedBuyPrice,
                        sellPrice: displayedSellPrice,
                        exitFeeAmount: displayedExitFeeAmount,
                        selectedCurrency: selectedCurrency
                    )

                    LazyVGrid(columns: inputColumns, spacing: 4) {
                        CurrencyTextField(placeholder: "Investment", text: $investmentAmount, selectedCurrency: selectedCurrency)
                        CurrencyTextField(placeholder: "Buy Price", text: $buyPrice, selectedCurrency: selectedCurrency)
                        CurrencyTextField(placeholder: "Sell Price", text: $sellPrice, selectedCurrency: selectedCurrency)
                        CurrencyTextField(placeholder: "Fee", text: $exitFeeAmount, selectedCurrency: selectedCurrency)
                    }

                    Button(action: calculate) {
                        Text("Calculate")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(calculationActionColor)
                    .foregroundStyle(.white)
                    .controlSize(.large)
                    .disabled(canCalculate == false)

                }
                .frame(maxWidth: 760)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, horizontalSizeClass == .regular ? 24 : 8)
                .padding(.vertical, 12)
            }
            .navigationBarTitle("Crypto Profit Calculator")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if store.completedPurchases.contains("com.removeads.profitloss") == false {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            paywallState.isPresented = true
                        } label: {
                            Image(systemName: "gift.fill")
                        }
                        .tint(.indigo)
                        .accessibilityLabel("Go Ad-Free")
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Picker("Currency", selection: $selectedCurrency) {
                        ForEach(currencySymbols, id: \.self) { symbol in
                            Image(systemName: symbolIcon(for: symbol))
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
            }
        }
    }

    private var inputColumns: [GridItem] {
        horizontalSizeClass == .regular
            ? [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)]
            : [GridItem(.flexible())]
    }

    private var canCalculate: Bool {
        guard let investment = Self.parseNumber(investmentAmount),
              let buyPrice = Self.parseNumber(buyPrice),
              Self.parseNumber(sellPrice) != nil else {
            return false
        }

        return investment > 0 && buyPrice > 0
    }

    private func calculate() {
        guard canCalculate else { return }

        displayedInvestmentAmount = emptyToZero(investmentAmount)
        displayedBuyPrice = emptyToZero(buyPrice)
        displayedSellPrice = emptyToZero(sellPrice)
        displayedExitFeeAmount = emptyToZero(exitFeeAmount)

        UIImpactFeedbackGenerator(style: .medium).impactOccurred()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
            showCalculatorInterstitialIfReady()
        }
    }

    private func showCalculatorInterstitialIfReady() {
        guard store.adsAreEligible,
              interstitialAdManager.shouldShowAd(minimumInterval: 60),
              let rootViewController = UIApplication.shared.getRootViewController() else {
            return
        }

        interstitialAdManager.showInterstitial(from: rootViewController)
    }
    
    // Helper function to parse numbers with international decimal separators
    private static func parseNumber(_ string: String) -> Double? {
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
                    .font(.system(.largeTitle, design: .rounded, weight: .black))
                    .monospacedDigit()
                    .foregroundColor(textColor(for: currentProfitLoss))
                    .contentTransition(.numericText())

                Text(breakEvenText(from: breakEvenSellPrice))
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.white.opacity(0.9))
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 100)
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
            guard let investment = CalculatorView.parseNumber(investmentAmount),
                  let buyPrice = CalculatorView.parseNumber(buyPrice),
                  let sell = CalculatorView.parseNumber(sellPrice),
                  let exitFee = CalculatorView.parseNumber(exitFeeAmount) else {
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
            guard let investment = CalculatorView.parseNumber(investmentAmount),
                  let buyPrice = CalculatorView.parseNumber(buyPrice),
                  let exitFee = CalculatorView.parseNumber(exitFeeAmount),
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
}
