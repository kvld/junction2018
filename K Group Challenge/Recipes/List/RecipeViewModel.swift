//
//  RecipeViewModel.swift
//  K Group Challenge
//
//  Created by Vladislav Kiryukhin on 24/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import UIKit

struct RecipeViewModel {
    let image: UIImage
    let title: String
    let summary: String
    
    let calories: String
    let carbohydrates: String
    let fats: String
    let proteins: String

    let caloriesPercent: Float
    let carbohydratesPercent: Float
    let fatsPercent: Float
    let proteinsPercent: Float
}
