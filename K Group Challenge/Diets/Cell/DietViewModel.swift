//
//  DietViewModel.swift
//  K Group Challenge
//
//  Created by Vladislav Kiryukhin on 24/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import UIKit

struct DietViewModel {
    struct Recipe {
        let title: String
        let imagePath: String
    }

    var recipes: [Recipe] = []
    let calories: String
    let price: String
    
    init(diet: WeekMenu) {
        var calories = 0
        for day in 0 ..< 7 {
            for recipe in diet.recipesForDay[day]! {
                if recipes.count < 5 {
                    recipes += [Recipe(title: recipe.title, imagePath: recipe.imageURL)]
                }
                calories += recipe.kcal
            }
        }
        self.calories = "\(calories/7) kcal/day"
        self.price = ""
    }
}
