//
//  FoodItemCollectionViewCell.swift
//  K Group Challenge
//
//  Created by Ostrenkiy on 24/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import UIKit

class FoodItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var slider: SectionedSlider!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    
    var sectionChanged: ((Int)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        slider.delegate = self
    }

    let states: [String] = [
        "Hate",
        "Don't like",
        "Could be better",
        "OK",
        "Like",
        "Love"
    ]
    
    func update(foodItem: FoodItem) {
        itemNameLabel.text = foodItem.title
        imageView.image = foodItem.image
        stateLabel.text = states[slider.selectedSection]
    }
}

extension FoodItemCollectionViewCell: SectionedSliderDelegate {
    func sectionChanged(slider: SectionedSlider, selected: Int) {
        stateLabel.text = states[selected]
        sectionChanged?(selected)
    }
}
