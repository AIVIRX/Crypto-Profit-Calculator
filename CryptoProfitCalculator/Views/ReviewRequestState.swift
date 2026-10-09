//
//  ReviewRequestState.swift
//  CryptoProfitCalculator
//

import SwiftUI

final class ReviewRequestState: ObservableObject {
    private var hasRequestedReviewThisSession = false

    func requestIfNeeded(_ requestReview: @escaping () -> Void) {
        guard hasRequestedReviewThisSession == false else { return }

        hasRequestedReviewThisSession = true
        requestReview()
    }
}
