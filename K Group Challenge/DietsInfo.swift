//
//  DietsInfo.swift
//  K Group Challenge
//
//  Created by Ostrenkiy on 25/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import Foundation
import SwiftyJSON

var diets: Diets?

class Diets {
    var menus: [WeekMenu] = []
    init(json: JSON) {
        for dietId in 0..<3 {
            menus.append(WeekMenu(json: json["\(dietId)"]))
        }
    }
}

class WeekMenu {
    var recipesForDay: [Int: [Recipe]] = [:]

    init(json: JSON) {
        //5 intakes, each contains info about weekdays
//        for weeklyIntakesJSON in json {
        for intakeId in 0..<6 {
            let weeklyIntakesJSON = json["\(intakeId)"]
            for (day, recipeJSON) in weeklyIntakesJSON.arrayValue.enumerated() {
                if recipesForDay[day] == nil {
                    recipesForDay[day] = []
                }
                recipesForDay[day]?.append(Recipe(json: recipeJSON))
            }
        }
    }
}

class Recipe {
    var title: String
    var description: String
    var kcal: Int
    var fat: Int
    var carbohydrate: Int
    var protein: Int
    var imageURL: String
    var instruction: String
    var ingredients: String
    var preparationTime: String
    
    init(json: JSON) {
        title = json["name"].string ?? ""
        description = json["description"].string ?? ""
        kcal = json["kcal_portion"].int ?? 0
        fat = json["fat_portion"].int ?? 0
        carbohydrate = json["carbohydrate_portion"].int ?? 0
        protein = json["protein_portion"].int ?? 0
        imageURL = json["img_url"].arrayValue[0].string ?? ""
        instruction = json["instruction"].string ?? ""
        ingredients = json["ingredients"].string ?? ""
        preparationTime = json["preparation_time"].string ?? ""
    }
}
