//
//  ViewController.swift
//  Grovs Example
//
//  Created by Grovs on 13.11.2024.
//

import UIKit
import Grovs

class ViewController: UIViewController, GrovsScreenTracking {

    /// Name reported by automatic screen tracking for this controller.
    var grovsScreenName: String? { "Home" }

    private let statusLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildDemoControls()
    }

    // MARK: - Messages (wired in the storyboard)

    @IBAction func showMessagesList(_ sender: Any) {
        Grovs.displayMessagesViewController(completion: {
            print("Messages dismissed")
        }, onFailure: {
            print("Messages could not be shown")
        })
    }

    // MARK: - Links

    @objc private func generateAndShareLink() {
        Grovs.generateLink(
            title: "Grovs example",
            subtitle: "Shared from the example app",
            data: ["screen": "home", "itemId": "42"],
            tags: ["example"],
            trackingCampaign: "example_app",
            trackingSource: "in_app",
            trackingMedium: "share_button"
        ) { [weak self] url in
            guard let self, let url else {
                self?.show("Link generation failed")
                return
            }
            self.show("Link: \(url)")
            let share = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            self.present(share, animated: true)
        }
    }

    // MARK: - Events

    @objc private func trackEvent() {
        Grovs.track("demo_button_tap", properties: ["source": "home", "count": 1], tags: ["example"])
        show("Tracked demo_button_tap")
    }

    @objc private func trackScreen() {
        // Manual screen views complement automatic tracking (on by default).
        Grovs.trackScreenView("Manual Screen", properties: ["origin": "button"])
        show("Tracked screen view")
    }

    // MARK: - Revenue

    @objc private func logPurchase() {
        Grovs.logCustomPurchase(type: .buy, priceInCents: 999, currency: "USD", productID: "premium_monthly") { [weak self] success in
            self?.show(success ? "Purchase logged" : "Purchase failed (queued for retry)")
        }
    }

    // MARK: - Consent

    @objc private func toggleConsent() {
        AppDelegate.hasConsent.toggle()
        Grovs.setSDK(enabled: AppDelegate.hasConsent)
        show(AppDelegate.hasConsent ? "Collection enabled" : "Collection disabled")
    }

    // MARK: - UI

    private func buildDemoControls() {
        let buttons: [(String, Selector)] = [
            ("Generate & share link", #selector(generateAndShareLink)),
            ("Track event", #selector(trackEvent)),
            ("Track screen view", #selector(trackScreen)),
            ("Log custom purchase", #selector(logPurchase)),
            ("Toggle collection (consent)", #selector(toggleConsent)),
        ]

        let stack = UIStackView(arrangedSubviews: buttons.map { title, action in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.addTarget(self, action: action, for: .touchUpInside)
            return button
        } + [statusLabel])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false

        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0
        statusLabel.font = .preferredFont(forTextStyle: .footnote)
        statusLabel.textColor = .secondaryLabel

        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
        ])
    }

    private func show(_ text: String) {
        print(text)
        statusLabel.text = text
    }
}
