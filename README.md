# Grovs iOS Example

A minimal UIKit app showing the [Grovs iOS SDK](https://github.com/grovs-io/grovs-iOS) 3.x in use.

## What it demonstrates

- **Configuration** with a consent flag (`enabled:`) and debug logging — `AppDelegate.swift`
- **Deep links** — the `GrovsDelegate` callback, plus `SceneDelegate` forwarding
- **SDK errors** — the optional `grovsDidEncounterError` callback
- **Link generation** with a share sheet
- **Events and screen tracking** — `track`, `trackScreenView`, `GrovsScreenTracking`, screen aliases; automatic screen tracking is on by default
- **Revenue** — `logCustomPurchase`
- **Consent** — `setSDK(enabled:)` toggled at runtime
- **Messages** — the messages list and push token registration

## Running it

1. Open `Grovs Example/Grovs Example.xcodeproj` in Xcode 15 or later.
2. Replace the API key in `AppDelegate.swift` with your project's key from the [Grovs dashboard](https://app.grovs.io) and set `useTestEnvironment` for the environment you want.
3. Update the bundle identifier, the associated domains in `Grovs Example.entitlements`, and the URL scheme in `Info.plist` to match your project — see the [iOS setup guides](https://docs.grovs.io/docs/how-to-guides/ios).
4. Run on a device or simulator. Push notifications need a physical device.

Full documentation: [docs.grovs.io/docs/sdk/ios](https://docs.grovs.io/docs/sdk/ios/quick-start).
