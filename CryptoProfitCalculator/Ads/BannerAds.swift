//
//  BannerAds.swift
//  CryptoProfitCalculator
//
//  Created by Maicol Cabreja on 11/11/23.
//

import SwiftUI
import GoogleMobileAds
@_spi(Experimental) import RevenueCatAdMob

struct AdView: UIViewRepresentable {
    var adUnitID: String
    var isAdsEnabled: Bool = true
    func makeCoordinator() -> Coordinator {
        return Coordinator(adUnitID: adUnitID)
    }
    
    func makeUIView(context: UIViewRepresentableContext<AdView>) -> BannerView {
        let bannerSize = AdSize(size: CGSize(width: 320, height: 50), flags: 0)
        let banner = BannerView(adSize: bannerSize)
        banner.adUnitID = adUnitID
        banner.rootViewController = UIApplication.shared.getRootViewController()
        if isAdsEnabled {
            banner.loadAndTrack(
                request: Request(),
                placement: "home_banner",
                delegate: context.coordinator
            )
        }
        banner.isHidden = !isAdsEnabled
        return banner
    }
    
    func updateUIView(_ uiView: BannerView, context: UIViewRepresentableContext<AdView>) {
        uiView.isHidden = !isAdsEnabled
    }
    
    class Coordinator: NSObject, BannerViewDelegate {
        private let adUnitID: String

        init(adUnitID: String) {
            self.adUnitID = adUnitID
        }

        func bannerViewDidReceiveAd(_ bannerView: BannerView) {
            print("bannerViewDidReceiveAd: \(adUnitID)")
        }

        func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
            print("bannerView failed: \(error.localizedDescription)")
        }

        func bannerViewDidRecordImpression(_ bannerView: BannerView) {
            print("bannerViewDidRecordImpression: \(adUnitID)")
        }

        func bannerViewDidRecordClick(_ bannerView: BannerView) {
            print("bannerViewDidRecordClick: \(adUnitID)")
        }

        func bannerViewWillPresentScreen(_ bannerView: BannerView) {
            print("bannerViewWillPresentScreen")
        }
        
        func bannerViewWillDismissScreen(_ bannerView: BannerView) {
            print("bannerViewWillDIsmissScreen")
        }
        
        func bannerViewDidDismissScreen(_ bannerView: BannerView) {
            print("bannerViewDidDismissScreen")
        }
    }
}

extension UIApplication{
    func getRootViewController()->UIViewController{
        guard let screen = self.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else{
            return .init()
        }
        
        return root
    }
}
