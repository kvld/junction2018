//
//  DietTableViewCell.swift
//  K Group Challenge
//
//  Created by Vladislav Kiryukhin on 24/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import UIKit

final class DietTableViewCell: UITableViewCell {
    static var reuseID = String(describing: self)

    @IBOutlet private weak var imagesView: ImageCarouselView!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var caloriesLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var itemsStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with viewModel: DietViewModel) {
        for subview in self.itemsStackView.arrangedSubviews {
            subview.removeFromSuperview()
            self.itemsStackView.removeArrangedSubview(subview)
        }

        self.priceLabel.text = viewModel.price
        self.caloriesLabel.text = viewModel.calories
        self.imagesView.set(images: viewModel.imagePaths)
        
        
//        for ingredient in viewModel.ingredients {
//            let ingredientView = UIStackView()
//            ingredientView.axis = .horizontal
//
//            let titleLabel = UILabel()
//            titleLabel.text = ingredient.title
//
//            let quantityLabel = UILabel()
//            quantityLabel.textAlignment = .right
//            quantityLabel.text = ingredient.quantity
//
//            quantityLabel.translatesAutoresizingMaskIntoConstraints = false
//            quantityLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
//
//            ingredientView.addArrangedSubview(titleLabel)
//            ingredientView.addArrangedSubview(quantityLabel)
//
//            self.itemsStackView.addArrangedSubview(ingredientView)
//        }
    }
}
