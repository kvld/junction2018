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

    private static let shadowColor = UIColor.black.cgColor
    private static let shadowOffset = CGSize(width: 0, height: 2)
    private static let shadowOpacity: Float = 0.04
    private static let shadowRadius: CGFloat = 18.0

    private var shadowLayer: CAShapeLayer?
    private var backgroundLayer: CAShapeLayer?

    override func awakeFromNib() {
        super.awakeFromNib()

        self.containerView.backgroundColor = .clear
        if shadowLayer == nil {
            dropShadow()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        DispatchQueue.main.async {
            CATransaction.setDisableActions(true)
            self.shadowLayer?.shadowPath = UIBezierPath(
                roundedRect: self.containerView.bounds,
                cornerRadius: 4
            ).cgPath
            self.shadowLayer?.frame = self.containerView.bounds
            CATransaction.setDisableActions(false)
        }
    }

    func configure(with viewModel: DietViewModel) {
        self.priceLabel.text = viewModel.price
        self.caloriesLabel.text = viewModel.calories
        self.imagesView.set(data: viewModel.recipes)
        
        
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

    private func dropShadow() {
        let shadowLayer = CAShapeLayer()
        shadowLayer.backgroundColor = UIColor.white.cgColor
        shadowLayer.masksToBounds = false
        shadowLayer.cornerRadius = 4.0

        shadowLayer.shouldRasterize = true
        shadowLayer.rasterizationScale = UIScreen.main.scale
        shadowLayer.shadowColor = DietTableViewCell.shadowColor
        shadowLayer.shadowOffset = DietTableViewCell.shadowOffset
        shadowLayer.shadowOpacity = DietTableViewCell.shadowOpacity
        shadowLayer.shadowRadius = DietTableViewCell.shadowRadius
        containerView.layer.insertSublayer(shadowLayer, at: 0)

        self.shadowLayer = shadowLayer
    }

}
