//
//  DetailRecipeViewController.swift
//  K Group Challenge
//
//  Created by Vladislav Kiryukhin on 24/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import UIKit

final class DetailRecipeViewController: UIViewController {
    @IBOutlet private weak var mainStackView: UIStackView!

    func configure(with viewModel: RecipeViewModel) {
        print(viewModel)
    }
}
