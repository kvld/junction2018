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
        let image: UIImage
    }

    let recipes: [Recipe]

    let calories: String
    let price: String
}
