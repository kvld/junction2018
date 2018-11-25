//
//  DetailRecipeViewController.swift
//  K Group Challenge
//
//  Created by Vladislav Kiryukhin on 24/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import UIKit
import Nuke

final class DetailRecipeViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var preparationTime: UILabel!
    @IBOutlet var dishType: UILabel!
    @IBOutlet var ingridientsList: UILabel!
    @IBOutlet var instruction: UILabel!

    func configure(with viewModel: RecipeViewModel) {
        loadViewIfNeeded()
        Nuke.loadImage(
            with: URL(string: viewModel.imageURL)!,
            options: ImageLoadingOptions(
                transition: ImageLoadingOptions.Transition.fadeIn(
                    duration: 0.1
                )
            ),
            into: imageView
        )
        title = viewModel.title
        titleLabel.text = viewModel.title
        ingridientsList.text = viewModel.ingredients
        instruction.text = viewModel.instruction
        print(viewModel)
    }
}
