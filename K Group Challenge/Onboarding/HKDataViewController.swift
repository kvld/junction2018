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

    @IBOutlet var ageContainer: UIView!
    @IBOutlet var sexContainer: UIView!
    @IBOutlet var weightContainer: UIView!
    @IBOutlet var heightContainer: UIView!
    @IBOutlet var basalEnergyContainer: UIView!
    @IBOutlet var activeEnergyContainer: UIView!


    override func viewDidLoad() {
        [ageValue, sexValue, weightLabel, heightLabel, basalEnergyValue, activeEnergyValue].forEach {
            $0.text = ""
        }
        [ageContainer, sexContainer, weightContainer, heightContainer, basalEnergyContainer, activeEnergyContainer].forEach {
            $0?.isHidden = true
            $0?.alpha = 0.0
        }
        UIApplication.shared.statusBarStyle = .lightContent
    }

    private var calculated: Bool = false
    @IBAction func buttonAction(_ sender: Any) {
        if calculated {
            performSegue(withIdentifier: "showNext", sender: self)
        }

        let data = try! healthService.getAgeSexAndBloodType()
        self.ageValue.text = "\(data.age) years"
        self.ageContainer.isHidden = false
        let superview = ageContainer.superview!
        superview.layoutIfNeeded()
        self.ageContainer.subviews[0].layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            self.button.alpha = 0.0
            self.ageContainer.alpha = 1.0
            superview.layoutIfNeeded()

        }, completion: { (_) in
            self.sexContainer.subviews[0].layoutIfNeeded()
            UIView.animate(withDuration: 0.3, delay: 0.7, animations: {
                self.sexContainer.isHidden = false
                self.sexContainer.alpha = 1.0
                self.sexValue.text = data.gender.stringRepresentation
                superview.layoutIfNeeded()

            }, completion: { (_) in
                self.healthService.getMass { [unowned self] (mass, _) in
                    let mass = mass ?? 81.4
                    DispatchQueue.main.async {
                        self.weightContainer.subviews[0].layoutIfNeeded()
                        UIView.animate(withDuration: 0.3, delay: 0.7, animations: {
                            self.weightContainer.isHidden = false
                            self.weightContainer.alpha = 1.0
                            self.weightLabel.text = "\(mass) kg"
                        }, completion: { (_) in
                            self.healthService.getHeight(completion: { [unowned self] (height, _) in
                                let height = height ?? 1.85
                                DispatchQueue.main.async {
                                    self.heightContainer.subviews[0].layoutIfNeeded()
                                    UIView.animate(withDuration: 0.3, delay: 0.7, animations: {
                                        self.heightContainer.isHidden = false
                                        self.heightContainer.alpha = 1.0
                                        self.heightLabel.text = "\(height) cm"
                                    }, completion: { (_) in
                                        self.healthService.getRestingEnergy(completion: { [unowned self] (restingCalories, _) in
                                            let restingCalories = restingCalories ?? 2087.2
                                            DispatchQueue.main.async {
                                                self.basalEnergyContainer.subviews[0].layoutIfNeeded()
                                                UIView.animate(withDuration: 0.3, delay: 0.7, animations: {
                                                    self.basalEnergyContainer.isHidden = false
                                                    self.basalEnergyContainer.alpha = 1.0
                                                    self.basalEnergyValue.text = "\(restingCalories.rounded()) kcal"
                                                }, completion: { (_) in
                                                    self.healthService.getActiveEnergy(completion: { [unowned self] (activeCalories, _) in
                                                        let activeCalories = activeCalories ?? 743.9
                                                        DispatchQueue.main.async {
                                                            self.activeEnergyContainer.subviews[0].layoutIfNeeded()
                                                            UIView.animate(withDuration: 0.3, delay: 0.7, animations: {
                                                                self.activeEnergyValue.text = "\(activeCalories.rounded()) kcal"
                                                                self.activeEnergyContainer.isHidden = false
                                                                self.activeEnergyContainer.alpha = 1.0
                                                            }, completion: { (_) in
                                                                let activityLevel: TotalEnergyExpenditure.ActivityLevel
                                                                switch activeCalories {
                                                                case 0..<500: activityLevel = .low
                                                                case 500..<1000: activityLevel = .moderate
                                                                default: activityLevel = .high
                                                                }

                                                                self.appDelegate.tte = Int(self.tteService.calculateTotalEnergyIntake(age: data.age, sex: data.gender, weight: mass, height: 100*height, activityLevel: activityLevel))
                                                                DispatchQueue.main.async {
                                                                    self.button.alpha = 1.0
                                                                    self.button.titleLabel?.text = "Show Result"
                                                                    self.button.setNeedsLayout()
                                                                    self.calculated = true
                                                                }
                                                            })
                                                        }
                                                    })
                                                })
                                            }
                                        })
                                    })
                                }
                            })
                        })
                    }
                }
            })
        })
    }
}

