//
//  CryptoProfitCalculatorApp.swift
//  CryptoProfitCalculator
//
//  Created by Maicol Cabreja on 11/11/23.
//

import SwiftUI
import AppTrackingTransparency
import GoogleMobileAds
import AdSupport
import FirebaseCore
import RevenueCat
import RevenueCatUI

enum AppTheme: String, CaseIterable, Identifiable {
    case system
    case light
    case dark

    var id: String { rawValue }

    var title: String {
        switch self {
        case .system: return "System"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }

    var preferredColorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .authorized:
                        MobileAds.shared.start(completionHandler: nil)
                        print(ASIdentifierManager.shared().advertisingIdentifier.uuidString)
                    case .denied:
                        MobileAds.shared.start(completionHandler: nil)
                        print(ASIdentifierManager.shared().advertisingIdentifier.uuidString)
                    case .restricted:
                        MobileAds.shared.start(completionHandler: nil)
                        print(ASIdentifierManager.shared().advertisingIdentifier.uuidString)
                    default:
                        MobileAds.shared.start(completionHandler: nil)
                    }
                }
            } else {
                MobileAds.shared.start(completionHandler: nil)
            }
        })
        
        FirebaseApp.configure()
        configureRevenueCat()
        
        return true
    }

    private func configureRevenueCat() {
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "appl_zsnpJwPScMadznqYKYjyIDDumiH")
    }
}

@main
struct CryptoProfitCalculatorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var store = Store()
    @StateObject private var interstitialAdManager = InterstitialAdManager()
    @StateObject private var paywallState = PaywallState()
    @StateObject private var reviewRequestState = ReviewRequestState()
    @AppStorage("appTheme") private var appTheme = AppTheme.system.rawValue

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .environmentObject(paywallState)
                .environmentObject(interstitialAdManager)
                .environmentObject(reviewRequestState)
            .preferredColorScheme(AppTheme(rawValue: appTheme)?.preferredColorScheme)
            .onAppear {
                Task { await store.refreshEntitlements() }
                if store.adsAreEligible {
                    interstitialAdManager.resumeLoadingAds()
                } else {
                    interstitialAdManager.stopLoadingAds()
                }
            }
            .onChange(of: store.adsAreEligible) { _, adsAreEligible in
                if adsAreEligible {
                    interstitialAdManager.resumeLoadingAds()
                } else {
                    paywallState.isPresented = false
                    interstitialAdManager.stopLoadingAds()
                }
            }
            .sheet(isPresented: $paywallState.isPresented) {
                StoreView()
                    .environmentObject(store)
                    .environmentObject(paywallState)
                    .presentationDragIndicator(.hidden)
            }
        }
    }
}
