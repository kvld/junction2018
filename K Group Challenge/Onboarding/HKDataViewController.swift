//
//  HKDataViewController.swift
//  K Group Challenge
//
//  Created by Filipp Fediakov on 24/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import UIKit

class HKDataViewController: UIViewController {

    @IBOutlet var button: UIButton!
    @IBOutlet var ageTitle: UILabel!
    @IBOutlet var ageValue: UILabel!
    @IBOutlet var sexTitle: UILabel!
    @IBOutlet var sexValue: UILabel!
    @IBOutlet var weightTitle: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var heightTitle: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var basalEnergyTitle: UILabel!
    @IBOutlet var basalEnergyValue: UILabel!
    @IBOutlet var activeEnergyTitle: UILabel!
    @IBOutlet var activeEnergyValue: UILabel!

    override func viewDidLoad() {
        [ageValue, sexValue, weightLabel, heightLabel, basalEnergyValue, activeEnergyValue].forEach {
            $0.text = ""
        }
        UIApplication.shared.statusBarStyle = .lightContent
    }

    private var calculated: Bool = false
    @IBAction func buttonAction(_ sender: Any) {
        if calculated {
            performSegue(withIdentifier: "showNext", sender: self)
        }


        let data = try! healthService.getAgeSexAndBloodType()
        ageValue.text = "\(data.age) years"
        sexValue.text = data.gender.stringRepresentation
        healthService.getMass { [unowned self] (mass, _) in
            let mass = mass ?? 81.4
            DispatchQueue.main.async {
                self.weightLabel.text = "\(mass) kg"
            }

            self.healthService.getHeight(completion: { [unowned self] (height, _) in
                let height = height ?? 1.85
                DispatchQueue.main.async {
                    self.heightLabel.text = "\(height) cm"
                }

                self.healthService.getRestingEnergy(completion: { [unowned self] (restingCalories, _) in
                    let restingCalories = restingCalories ?? 2087.2
                    DispatchQueue.main.async {
                        self.basalEnergyValue.text = "\(restingCalories.rounded()) kcal"
                    }

                    self.healthService.getActiveEnergy(completion: { [unowned self] (activeCalories, _) in
                        let activeCalories = activeCalories ?? 743.9
                        DispatchQueue.main.async {
                            self.activeEnergyValue.text = "\(activeCalories.rounded()) kcal"
                        }
                        let activityLevel: TotalEnergyExpenditure.ActivityLevel
                        switch activeCalories {
                        case 0..<500: activityLevel = .low
                        case 500..<1000: activityLevel = .moderate
                        default: activityLevel = .high
                        }

                        self.appDelegate.tte = Int(self.tteService.calculateTotalEnergyIntake(age: data.age, sex: data.gender, weight: mass, height: 100*height, activityLevel: activityLevel))
                        DispatchQueue.main.async {
                            self.button.titleLabel?.text = "Show Result"
                            self.button.setNeedsLayout()
                            self.calculated = true
                        }
                    })
                })
            })
        }
    }
}
