//
//  SceneDelegate.swift
//  Grovs Example
//
//  Created by Grovs on 13.11.2024.
//

import UIKit
import Grovs

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }

        Grovs.handleSceneDelegate(options: connectionOptions)
    }

    // Handle open URL contexts
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        Grovs.handleSceneDelegate(openURLContexts: URLContexts)
    }

    // Handle continue user activity
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        Grovs.handleSceneDelegate(continue: userActivity)
    }
}
