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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        Grovs.setDebug(level: .info)

        Grovs.configure(APIKey: "grovst_06e36086dad3e934289560e3ca59527282030868f8c844629516c6e6c67bbf1f", delegate: self)
        Grovs.useTestEnvironment = true


        Grovs.userIdentifier = "My user identifier"
        Grovs.userAttributes = ["user_id": "1234", "email": "support@grovs.io"]

        Grovs.useTestEnvironment = true

        requestNotificationAuthorization()

        return true
    }

    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    // Register for remote notifications
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else if let error = error {
                print("Error requesting authorization for notifications: \(error.localizedDescription)")
            }
        }
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to a string
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()

        print("Device Token: \(token)")

        // You can pass this token to your library
        Grovs.pushToken = token
    }

    // MARK: Grovs SDK

    func grovsReceivedPayloadFromDeeplink(payload: [String : Any]) {
        print("Paylooad \(payload)")
    }
}

