//
//  StoreView.swift
//  CryptoProfitCalculator
//
//  Created by Maicol Cabreja on 9/21/24.
//

import SwiftUI
import FirebaseAnalytics
import RevenueCatUI

struct StoreView: View {
    var body: some View {
        PaywallView(displayCloseButton: true)
        .onAppear {
            Analytics.logEvent(
                AnalyticsEventScreenView,
                parameters: [AnalyticsParameterScreenName: "Paywall"]
            )
        }
    }
}
