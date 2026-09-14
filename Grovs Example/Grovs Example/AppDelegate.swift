//
//  AppDelegate.swift
//  Grovs Example
//
//  Created by Grovs on 13.11.2024.
//

import UIKit
import UserNotifications
import Grovs

@main
class AppDelegate: UIResponder, UIApplicationDelegate, GrovsDelegate {

    /// Stand-in for your consent store. The SDK collects nothing while this is false.
    static var hasConsent: Bool {
        get { UserDefaults.standard.object(forKey: "grovsConsent") as? Bool ?? true }
        set { UserDefaults.standard.set(newValue, forKey: "grovsConsent") }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Grovs.setDebug(level: .info)

        // Replace the key with your project's API key from the Grovs dashboard.
        // `enabled:` is not persisted by the SDK: pass your stored consent on every launch.
        Grovs.configure(
            APIKey: "grovst_06e36086dad3e934289560e3ca59527282030868f8c844629516c6e6c67bbf1f",
            useTestEnvironment: true,
            enabled: Self.hasConsent,
            delegate: self
        ) { success in
            print("Grovs configured: \(success)")
        }

        // Identify the user after configure.
        Grovs.userIdentifier = "My user identifier"
        Grovs.userAttributes = ["user_id": "1234", "email": "support@grovs.io"]

        // Friendly dashboard names for automatically tracked screens.
        Grovs.setScreenAliases(["ViewController": "Home"])

        return true
    }

    /// Ask in context rather than at launch: a permission alert at launch leaves the app
    /// inactive, so messages set to display automatically wait for the next activation.
    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else if let error = error {
                print("Error requesting authorization for notifications: \(error.localizedDescription)")
            }
        }
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device Token: \(token)")
        Grovs.pushToken = token
    }

    // MARK: - GrovsDelegate (called on the main thread)

    func grovsReceivedPayloadFromDeeplink(link: String?, payload: [String: Any]?, tracking: [String: Any]?) {
        print("Deep link: \(link ?? "-")")
        print("Payload: \(payload ?? [:])")
        print("Tracking: \(tracking ?? [:])")
        // Route on payload data, e.g. `payload?["screen"] as? String`.
    }

    func grovsDidEncounterError(_ error: GrovsError, message: String) {
        print("Grovs error \(error): \(message)")
    }
}
