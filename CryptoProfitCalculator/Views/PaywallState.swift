//
//  PaywallState.swift
//  CryptoProfitCalculator
//
//  Created by Codex on 2/21/26.
//

import SwiftUI

final class PaywallState: ObservableObject {
    @Published var isPresented = false
    private(set) var hasAutoPresentedThisSession = false

    func presentAutoIfNeeded(_ shouldShow: Bool) {
        guard shouldShow, hasAutoPresentedThisSession == false else { return }
        hasAutoPresentedThisSession = true
        isPresented = true
    }
}
