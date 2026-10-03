# Crypto Profit & Loss Calculator

An iOS app for quickly estimating cryptocurrency gains, losses, and exit fees. It also includes a bite-sized crypto trivia experience and optional ad-free purchase.

[View Crypto Profit Loss Calculator on the App Store](https://apps.apple.com/us/app/crypto-profit-loss-calculator/id1638849680)

## Highlights

- Calculates estimated profit or loss from an investment amount, buy price, sell price, and exit fee.
- Supports multiple currency symbols and persists the selected preference.
- Includes crypto education trivia organized into chapters.
- Uses RevenueCat for the ad-free entitlement and Google Mobile Ads for supported ad experiences.
- Integrates Firebase Analytics for product insights.

## Tech stack

- Swift and SwiftUI
- iOS 16+
- Swift Package Manager
- Firebase
- Google Mobile Ads
- RevenueCat

## Run locally

1. Open `CryptoProfitCalculator.xcodeproj` in Xcode.
2. Let Xcode resolve the Swift Package Manager dependencies.
3. Select an iOS simulator or connected device and run the `CryptoProfitCalculator` scheme.

The project includes platform configuration for Firebase, RevenueCat, and Google Mobile Ads. Use your own service configuration when distributing a derivative build.

## Repository conventions

Generated Xcode user data, local workspace state, and build products are intentionally ignored. Shared project and scheme files remain version-controlled so the project opens consistently for every contributor.

## License

This repository is proprietary software. See [LICENSE](LICENSE) for usage restrictions.
