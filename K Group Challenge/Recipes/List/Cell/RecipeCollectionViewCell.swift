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

    private static let shadowColor = UIColor.black.cgColor
    private static let shadowOffset = CGSize(width: 0, height: 2)
    private static let shadowOpacity: Float = 0.04
    private static let shadowRadius: CGFloat = 18.0

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var caloriesLabel: UILabel!
    @IBOutlet private weak var proteinsLabel: UILabel!
    @IBOutlet private weak var fatsLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var carbohydratesLabel: UILabel!

    private var caloriesCircle: CircularProgressBar!
    private var proteinsCircle: CircularProgressBar!
    private var fatsCircle: CircularProgressBar!
    private var descriptionCircle: CircularProgressBar!
    private var carbohydratesCircle: CircularProgressBar!

    private var shadowLayer: CAShapeLayer?

    override func awakeFromNib() {
        super.awakeFromNib()

        self.contentView.clipsToBounds = false
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

    private func dropShadow() {
        let shadowLayer = CAShapeLayer()
        shadowLayer.backgroundColor = UIColor.white.cgColor
        shadowLayer.masksToBounds = false
        shadowLayer.cornerRadius = 4.0

        shadowLayer.shouldRasterize = true
        shadowLayer.rasterizationScale = UIScreen.main.scale
        shadowLayer.shadowColor = RecipeCollectionViewCell.shadowColor
        shadowLayer.shadowOffset = RecipeCollectionViewCell.shadowOffset
        shadowLayer.shadowOpacity = RecipeCollectionViewCell.shadowOpacity
        shadowLayer.shadowRadius = RecipeCollectionViewCell.shadowRadius
        containerView.layer.insertSublayer(shadowLayer, at: 0)

        self.shadowLayer = shadowLayer
    }

    func configure(with viewModel: RecipeViewModel) {
        self.titleLabel.text = viewModel.title
        self.imageView.image = viewModel.image
        self.descriptionLabel.text = viewModel.summary

        self.caloriesLabel.text = viewModel.calories
        self.proteinsLabel.text = viewModel.proteins
        self.fatsLabel.text = viewModel.fats
        self.carbohydratesLabel.text = viewModel.carbohydrates

        // circles
        if self.caloriesCircle == nil {
            let xPosition1 = self.caloriesLabel.center.x
            let yPosition1 = self.caloriesLabel.center.y
            let position1 = CGPoint(x: xPosition1, y: yPosition1)
            let layer1 = self.makeCircle(position: position1)
            self.caloriesCircle = layer1 as! CircularProgressBar
            self.caloriesLabel.superview!.layer.addSublayer(layer1)
        }

        if self.proteinsCircle == nil {
            let xPosition2 = self.proteinsLabel.center.x
            let yPosition2 = self.proteinsLabel.center.y
            let position2 = CGPoint(x: xPosition2, y: yPosition2)
            let layer2 = self.makeCircle(position: position2)
            self.proteinsCircle = layer2 as! CircularProgressBar
            self.proteinsLabel.superview!.layer.addSublayer(layer2)
        }

        if self.fatsCircle == nil {
            let xPosition3 = self.fatsLabel.center.x
            let yPosition3 = self.fatsLabel.center.y
            let position3 = CGPoint(x: xPosition3, y: yPosition3)
            let layer3 = self.makeCircle(position: position3)
            self.fatsCircle = layer3 as! CircularProgressBar
            self.fatsLabel.superview!.layer.addSublayer(layer3)
        }

        if self.carbohydratesCircle == nil {
            let xPosition4 = self.carbohydratesLabel.center.x
            let yPosition4 = self.carbohydratesLabel.center.y
            let position4 = CGPoint(x: xPosition4, y: yPosition4)
            let layer4 = self.makeCircle(position: position4)
            self.carbohydratesCircle = layer4 as! CircularProgressBar
            self.carbohydratesLabel.superview!.layer.addSublayer(layer4)
        }

        self.carbohydratesCircle.progress = CGFloat(viewModel.carbohydratesPercent * 100)
        self.proteinsCircle.progress = CGFloat(viewModel.proteinsPercent * 100)
        self.caloriesCircle.progress = CGFloat(viewModel.caloriesPercent * 100)
        self.fatsCircle.progress = CGFloat(viewModel.fatsPercent * 100)
    }

    private func makeCircle(position: CGPoint) -> CALayer {
        let progressBar = CircularProgressBar(
            radius: 25,
            position: position,
            innerTrackColor: UIColor(red: 140/255, green: 160/255, blue: 240/255, alpha: 1.0),
            outerTrackColor: UIColor(red: 236/255, green: 241/255, blue: 248/255, alpha: 1.0),
            lineWidth: 4
        )
        return progressBar
    }
}
