//
//  SettingsView.swift
//  CryptoProfitCalculator
//
//  Created by Maicol Cabreja on 9/21/24.
//

import SwiftUI
import FirebaseAnalytics

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var paywallState: PaywallState
    @EnvironmentObject private var store: Store
    private let url = URL(string: "https://apps.apple.com/us/app/crypto-profit-loss-calculator/id1638849680")!
    private let stockAppURL = URL(string: "https://apps.apple.com/us/app/stock-profit-calculator-2025/id6479931561")!
    @Environment(\.requestReview) var requestReview
    let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient for a modern look
                LinearGradient(gradient: Gradient(colors: [Color(.systemBackground), Color(.secondarySystemBackground)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        HStack {
                            Text("Settings")
                                .font(.largeTitle.bold())
                                .padding(.leading)
                            Spacer()
                        }
                        .padding(.top, 8)

                        // Premium Section
                        if !store.completedPurchases.contains("com.removeads.profitloss") {
                            Button(action: {
                                paywallState.isPresented = true
                            }) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        HStack{
                                            Text("Premium")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Image(systemName: "crown.fill")
                                                .foregroundColor(.yellow)
                                                .font(.system(size: 14))
                                        }
                                        Text("Unlock Premium Features")
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .background(RoundedRectangle(cornerRadius: 12).fill(Color.indigo.gradient))
                                .padding(.horizontal)
                                .padding(.top)
                            }
                        }

                        // Actions Section
                        SectionCard {
                            VStack(spacing: 12) {
                                ShareLink(item: url) {
                                    ModernButtonLabel(title: "Share Crypto Profit Loss Calculator", systemImage: "square.and.arrow.up")
                                }
                                Link(destination: stockAppURL) {
                                    HStack(spacing: 12) {
                                        Image("stockprofit")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 28, height: 28)
                                            .clipShape(RoundedRectangle(cornerRadius: 6))
                                        Text("Stock Profit Calculator")
                                            .fontWeight(.semibold)
                                            .foregroundColor(.primary)
                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color(.secondarySystemBackground).opacity(0.7))
                                    .cornerRadius(12)
                                }
                                Button(action: { requestReview() }) {
                                    ModernButtonLabel(title: "Rate Our App", systemImage: "bubble.left.and.bubble.right")
                                }
                            }
                        }
                        
                        // Links Section
                        SectionCard {
                            VStack(spacing: 12) {
                                Link(destination: URL(string: "https://www.aivirx.com/crypto-profit-loss-calculator/privacy-policy")!) {
                                    ModernButtonLabel(title: "Privacy Policy", systemImage: "lock.shield")
                                }
                                Link(destination: URL(string: "https://www.aivirx.com/contact")!) {
                                    ModernButtonLabel(title: "Contact Us", systemImage: "envelope")
                                }
                            }
                        }

                        // Build number at the bottom
                        if let build = buildNumber {
                            Text("App Build: \(build)")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .padding(.top, 16)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                }
            }
        }
    }
}

// MARK: - SectionCard for modern card look
struct SectionCard<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        VStack {
            content
        }
        .background(.ultraThinMaterial)
        .cornerRadius(18)
        .shadow(color: Color.primary.opacity(0.07), radius: 8, x: 0, y: 4)
    }
}

// MARK: - ModernButtonLabel for unified button style
struct ModernButtonLabel: View {
    let title: String
    let systemImage: String
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: systemImage)
                .font(.title3)
                .foregroundColor(.accentColor)
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground).opacity(0.7))
        .cornerRadius(12)
    }
}
