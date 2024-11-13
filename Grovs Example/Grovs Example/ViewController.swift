//
//  ViewController.swift
//  Grovs Example
//
//  Created by Grovs on 13.11.2024.
//

import UIKit
import Grovs

class ViewController: UIViewController {

    @IBAction func showMessagesList(_ sender: Any) {
        Grovs.displayMessagesViewController(completion: nil)
    }
}

