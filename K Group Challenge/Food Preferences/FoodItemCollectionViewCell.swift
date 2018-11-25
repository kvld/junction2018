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
    @IBOutlet weak var itemEmoji: UILabel!
    
    var sectionChanged: ((Int)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        slider.delegate = self
    }

    //TODO: Заменить на emoji
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
        itemEmoji.text = foodItem.emoji
        stateLabel.text = states[slider.selectedSection]
    }
}

extension FoodItemCollectionViewCell: SectionedSliderDelegate {
    func sectionChanged(slider: SectionedSlider, selected: Int) {
        stateLabel.text = states[selected]
        sectionChanged?(selected)
    }
}
