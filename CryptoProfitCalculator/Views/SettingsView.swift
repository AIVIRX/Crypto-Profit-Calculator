//
//  SettingsView.swift
//  CryptoProfitCalculator
//
//  Created by Maicol Cabreja on 9/21/24.
//

import SwiftUI
import FirebaseAnalytics

struct SettingsView: View {
    @EnvironmentObject private var paywallState: PaywallState
    @EnvironmentObject private var store: Store
    @AppStorage("appTheme") private var appTheme = AppTheme.system.rawValue
    private let url = URL(string: "https://apps.apple.com/us/app/crypto-profit-loss-calculator/id1638849680")!
    private let stockAppURL = URL(string: "https://apps.apple.com/us/app/stock-profit-calculator-2025/id6479931561")!
    let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    var body: some View {
        NavigationStack {
            Form {
                Section("Appearance") {
                    Picker("Theme", selection: $appTheme) {
                        ForEach(AppTheme.allCases) { theme in
                            Text(theme.title).tag(theme.rawValue)
                        }
                    }
                }

                if !store.completedPurchases.contains("com.removeads.profitloss") {
                    Section {
                        Button { paywallState.isPresented = true } label: {
                            Label("Go Ad-Free", systemImage: "crown")
                        }
                    } header: {
                        Text("Premium")
                    } footer: {
                        Text("Remove ads and support continued development.")
                    }
                }

                Section("Share and Rate") {
                    ShareLink(item: url) {
                        Label("Share Crypto Profit Loss Calculator", systemImage: "square.and.arrow.up")
                    }
                    Link(destination: url) {
                        Label("Rate Our App", systemImage: "star")
                    }
                    Link(destination: stockAppURL) {
                        Label("Stock Profit Calculator", systemImage: "chart.line.uptrend.xyaxis")
                    }
                }

                Section("Support") {
                    Link("Privacy Policy", destination: URL(string: "https://www.aivirx.com/crypto-profit-loss-calculator/privacy-policy")!)
                    Link("Contact Us", destination: URL(string: "https://www.aivirx.com/contact")!)
                }

                if let build = buildNumber {
                    Section {
                        LabeledContent("Build", value: build)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
