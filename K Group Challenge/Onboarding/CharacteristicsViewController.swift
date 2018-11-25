//
//  CharacteristicsViewController.swift
//  K Group Challenge
//
//  Created by Ostrenkiy on 24/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import UIKit

class CharacteristicsViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    @IBOutlet var kcalLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        kcalLabel.text = "\(appDelegate.tte) kcal"
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        showNext()
    }
    
    func showNext() {
        performSegue(withIdentifier: "showNext", sender: nil)
    }
}
