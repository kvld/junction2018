//
//  DietViewModel.swift
//  K Group Challenge
//
//  Created by Vladislav Kiryukhin on 24/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import UIKit

struct DietViewModel {
//    struct Ingredient {
//        let title: String
//        let quantity: String
//    }

    let images: [UIImage]
//    let ingredients: [Ingredient]

    let calories: String
    let price: String
    var imagePaths: [String] = []
    
    init(diet: WeekMenu) {
        var calories = 0
        for day in 0 ..< 7 {
            for recipe in diet.recipesForDay[day]! {
                if imagePaths.count < 5 {
                    imagePaths += [recipe.imageURL]
                }
                calories += recipe.kcal
            }
        }
        self.calories = "\(calories/7) kcal/day"
        self.images = []
        self.price = ""
    }
}
