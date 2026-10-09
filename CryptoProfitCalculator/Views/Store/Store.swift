//
//  Store.swift
//  CryptoProfitCalculator
//
//  Created by Maicol Cabreja on 11/11/23.
//

import Foundation
import RevenueCat

@MainActor
final class Store: NSObject, ObservableObject {
    @Published var completedPurchases = [String]() {
        didSet {
            saveCompletedPurchases()
        }
    }
    @Published private(set) var adsAreEligible = false

    private let removeAdsProductID = "com.removeads.profitloss"
    private let removeAdsEntitlementID = "remove_ads"
    private let userDefaultsKey = "completedPurchases"

    override init() {
        super.init()
        loadStoredPurchases()
        Purchases.shared.delegate = self
        Task { await refreshEntitlements() }
    }

    func loadStoredPurchases() {
        if let storedPurchases = UserDefaults.standard.object(forKey: userDefaultsKey) as? [String] {
            completedPurchases = storedPurchases
        }
        Task { await refreshEntitlements() }
    }

    func restorePurchases() {
        Task {
            do {
                let customerInfo = try await Purchases.shared.restorePurchases()
                applyEntitlements(from: customerInfo)
            } catch {
                print("Failed to restore purchases: \(error)")
            }
        }
    }

    func refreshEntitlements() async {
        do {
            let customerInfo = try await Purchases.shared.customerInfo()
            applyEntitlements(from: customerInfo)
        } catch {
            // Keep ads off when entitlement status cannot be verified.
            adsAreEligible = false
            print("Failed to refresh RevenueCat entitlements: \(error)")
        }
    }

    private func applyEntitlements(from customerInfo: CustomerInfo) {
        let hasRemoveAds = customerInfo.entitlements[removeAdsEntitlementID]?.isActive == true
        let updatedPurchases = hasRemoveAds ? [removeAdsProductID] : []
        adsAreEligible = !hasRemoveAds

        if updatedPurchases != completedPurchases {
            completedPurchases = updatedPurchases
        }
    }

    private func saveCompletedPurchases() {
        UserDefaults.standard.setValue(completedPurchases, forKey: userDefaultsKey)
    }
}

extension Store: PurchasesDelegate {
    nonisolated func purchases(_ purchases: Purchases, receivedUpdated customerInfo: CustomerInfo) {
        Task { @MainActor in
            self.applyEntitlements(from: customerInfo)
        }
    }
}
