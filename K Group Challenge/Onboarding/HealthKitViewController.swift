//
//  HealthKitViewController.swift
//  K Group Challenge
//
//  Created by Ostrenkiy on 24/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import UIKit

class HealthKitViewController: UIViewController {
    @IBOutlet weak var button: UIButton!

    @IBAction func buttonPressed(_ sender: Any) {
        healthService.authorize { [unowned self] (success, _) in
            if success {
                DispatchQueue.main.async {
                    self.showNext()
                }
            }
        }
    }
    
    func showNext() {
        performSegue(withIdentifier: "showNext", sender: nil)
    }
}
