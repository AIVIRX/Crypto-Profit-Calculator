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
    var body: some Scene {
        WindowGroup {
            VStack{
                if !store.completedPurchases.contains("com.removeads.profitloss") {
                    let adsEnabled = !store.completedPurchases.contains("com.removeads.profitloss")
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        AdView(adUnitID: AdUnitID.finalAds, isAdsEnabled: adsEnabled)
                            .frame(width: 320, height: 50)
                            .padding(5)
                    }
                    
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        AdView(adUnitID: AdUnitID.finalAds, isAdsEnabled: adsEnabled)
                            .frame(width: 468, height: 60)
                            .padding(5)
                    }
                }
                
                ContentView()
                    .environmentObject(store)
                    .environmentObject(paywallState)
                    .environmentObject(interstitialAdManager)
            }
            .onAppear {
                Task { await store.refreshEntitlements() }
                if store.completedPurchases.contains("com.removeads.profitloss") {
                    interstitialAdManager.stopLoadingAds()
                } else {
                    interstitialAdManager.resumeLoadingAds()
                    paywallState.presentAutoIfNeeded(true)
                }
            }
            .onChange(of: store.completedPurchases) { _, purchases in
                if purchases.contains("com.removeads.profitloss") {
                    paywallState.isPresented = false
                    interstitialAdManager.stopLoadingAds()
                } else {
                    paywallState.presentAutoIfNeeded(true)
                    interstitialAdManager.resumeLoadingAds()
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
