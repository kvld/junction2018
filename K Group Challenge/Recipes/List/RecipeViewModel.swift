//
//  RecipeViewModel.swift
//  K Group Challenge
//
//  Created by Vladislav Kiryukhin on 24/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import UIKit

struct RecipeViewModel {
//    let image: UIImage
    let imageURL: String
    let title: String
    let summary: String
    let instruction: String
    let ingredients: String
    
    let calories: String
    let carbohydrates: String
    let fats: String
    let proteins: String

    let caloriesPercent: Float
    let carbohydratesPercent: Float
    let fatsPercent: Float
    let proteinsPercent: Float
    
    init(recipe: Recipe, dayCalories: Int, dayCarbohydrates: Int, dayFats: Int, dayProteins: Int) {
        self.imageURL = recipe.imageURL
        self.title = recipe.title
        self.summary = recipe.description
        self.calories = "\(recipe.kcal)"
        self.carbohydrates = "\(recipe.carbohydrate)"
        self.fats = "\(recipe.fat)"
        self.proteins = "\(recipe.protein)"
        self.instruction = "\(recipe.instruction)"
        
        self.caloriesPercent = Float(recipe.kcal)/Float(dayCalories)
        self.carbohydratesPercent = Float(recipe.carbohydrate)/Float(dayCarbohydrates)
        self.fatsPercent = Float(recipe.fat)/Float(dayFats)
        self.proteinsPercent = Float(recipe.protein)/Float(dayProteins)

        self.ingredients = "\(recipe.ingredients)"
    }
}
