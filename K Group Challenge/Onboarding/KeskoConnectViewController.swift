//
//  KeskoConnectViewController.swift
//  K Group Challenge
//
//  Created by Ostrenkiy on 24/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import UIKit

class KeskoConnectViewController: UIViewController {
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    @IBAction func buttonPressed(_ sender: Any) {
        showNext()
    }
    
    func showNext() {
        performSegue(withIdentifier: "showNext", sender: nil)
    }
}
