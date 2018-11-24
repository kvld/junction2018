//
//  RecipeCollectionViewCell.swift
//  K Group Challenge
//
//  Created by Vladislav Kiryukhin on 24/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    static let reuseID = String(describing: self)

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var caloriesLabel: UILabel!
    @IBOutlet private weak var proteinsLabel: UILabel!
    @IBOutlet private weak var fatsLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var carbohydratesLabel: UILabel!

    func configure(with viewModel: RecipeViewModel) {
        self.titleLabel.text = viewModel.title
        self.imageView.image = viewModel.image
        self.descriptionLabel.text = viewModel.summary

        self.caloriesLabel.text = viewModel.calories
        self.proteinsLabel.text = viewModel.proteins
        self.fatsLabel.text = viewModel.fats
        self.carbohydratesLabel.text = viewModel.carbohydrates
    }
}
