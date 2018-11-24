//
//  TotalEnergyIntakeService.swift
//  K Group Challenge
//
//  Created by Filipp Fediakov on 24/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import Foundation


/// https://en.wikipedia.org/wiki/Harris–Benedict_equation
class TotalEnergyExpenditure {

    enum ActivityLevel {
        case low, moderate, high
    }

    enum WeightGoal {
        case keep, lose, gain
    }

    func calculateTotalEnergyIntake(age: Int, sex: Sex, weight: Double, height: Double, activityLevel: ActivityLevel, goal: WeightGoal = .keep) -> Double {
        let constant: Double
        switch sex {
        case .female: constant = 5
        case .male: constant = -161
        case .other: constant = (5-161) / 2.0
        }

        let multiplier: Double

        switch activityLevel {
        case .low: multiplier = 1.53
        case .moderate: multiplier = 1.76
        case .high: multiplier = 2.25
        }

        let goalMultiplier: Double
        switch goal {
        case .keep: goalMultiplier = 1.0
        case .lose: goalMultiplier = 0.81
        case .gain: goalMultiplier = 1.2
        }

        var bmr = 10.0 * weight
        bmr += 6.25 * height
        bmr += -5.0 * Double(age)
        bmr += constant

        let totalyEnergyIntake = bmr * multiplier
        let goalConsideredIntake = totalyEnergyIntake * goalMultiplier
        return goalConsideredIntake
    }
}
