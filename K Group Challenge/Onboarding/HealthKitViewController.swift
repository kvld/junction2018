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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.barTintColor = UIColor(
            patternImage: UIImage(named: "gradient_big")!.resizableImage(
                withCapInsets: UIEdgeInsets.zero,
                resizingMode: .stretch
            )
        )
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
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
