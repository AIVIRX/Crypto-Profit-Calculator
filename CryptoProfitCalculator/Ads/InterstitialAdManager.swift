//
//  InterstitialAdManager.swift
//  CryptoProfitCalculator
//
//  Created by AI on 2024-06-10.
//

import GoogleMobileAds
import SwiftUI
@_spi(Experimental) import RevenueCatAdMob

class InterstitialAdManager: NSObject, ObservableObject, FullScreenContentDelegate {
    private var interstitial: InterstitialAd?
    @Published var isAdReady: Bool = false
    private let adUnitID = "ca-app-pub-2043555402127024/8697453879"
    
    // Smart ad logic
    private var calculationCount = 0
    private var navigationCount = 0
    private var lastAdShownTime = Date.distantPast
    private let minimumAdInterval: TimeInterval = 30 // Default interval between ads
    private let navigationsBeforeAd = 5 // Show ad after 5 navigation events
    
    // Ad loading control
    private var shouldLoadAds: Bool = true

    func loadInterstitial() {
        guard shouldLoadAds else { return }

        Task { [weak self] in
            guard let self else { return }
            do {
                let loadedAd = try await InterstitialAd.loadAndTrack(
                    withAdUnitID: adUnitID,
                    request: Request(),
                    placement: "calculator_interstitial",
                    fullScreenContentDelegate: self
                )
                await MainActor.run {
                    self.interstitial = loadedAd
                    self.isAdReady = true
                    print("Interstitial ad loaded successfully")
                }
            } catch {
                await MainActor.run {
                    self.isAdReady = false
                    print("Failed to load interstitial ad: \(error.localizedDescription)")
                }
            }
        }
    }

    func showInterstitial(from rootViewController: UIViewController, completion: (() -> Void)? = nil) {
        guard shouldLoadAds else {
            completion?()
            return
        }
        guard let interstitial = interstitial else {
            print("Interstitial ad wasn't ready")
            completion?()
            return
        }
        interstitial.present(from: rootViewController)
        self.isAdReady = false
        lastAdShownTime = Date()
        completion?()
    }
    
    // Smart ad showing logic
    func shouldShowAd(minimumInterval: TimeInterval? = nil) -> Bool {
        guard shouldLoadAds else { return false }
        let timeSinceLastAd = Date().timeIntervalSince(lastAdShownTime)
        return timeSinceLastAd >= (minimumInterval ?? self.minimumAdInterval) && isAdReady
    }
    
    func recordNavigation() {
        navigationCount += 1
        print("Navigation count: \(navigationCount)")
    }
    
    func shouldShowAdAfterNavigation() -> Bool {
        return navigationCount >= navigationsBeforeAd && shouldShowAd()
    }
    
    func resetCounters() {
        calculationCount = 0
        navigationCount = 0
    }
    
    func showSmartInterstitial(from rootViewController: UIViewController, completion: (() -> Void)? = nil) {
        guard shouldLoadAds else {
            completion?()
            return
        }
        if shouldShowAd() {
            showInterstitial(from: rootViewController, completion: completion)
            resetCounters()
        } else {
            completion?()
        }
    }

    // Delegate method to reset ad availability after it's shown
    func adDidDismissFullScreenContent(_ ad: any FullScreenPresentingAd) {
        DispatchQueue.main.async {
            if self.shouldLoadAds {
                self.loadInterstitial()
            }
            self.isAdReady = false
        }
    }
    
    func ad(_ ad: any FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        DispatchQueue.main.async {
            self.isAdReady = false
            print("Interstitial ad failed to present: \(error.localizedDescription)")
        }
    }
    
    // Method to stop loading ads (called when user purchases remove ads IAP)
    func stopLoadingAds() {
        shouldLoadAds = false
        isAdReady = false
        interstitial = nil
    }
    
    // Method to resume loading ads (if needed for testing or other scenarios)
    func resumeLoadingAds() {
        shouldLoadAds = true
        loadInterstitial()
    }
}

extension UIApplication {
    func getRootViewController() -> UIViewController? {
        let activeScene = connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first { $0.activationState == .foregroundActive }

        return activeScene?.windows.first(where: \.isKeyWindow)?.rootViewController
            ?? activeScene?.windows.first?.rootViewController
    }
}
