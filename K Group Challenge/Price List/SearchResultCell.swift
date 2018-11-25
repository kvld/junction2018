//
//  SearchResultCell.swift
//  PullUpControllerDemo
//
//  Created by Mario on 04/11/2017.
//  Copyright © 2017 Mario. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!

    func configure(item: ReceiptItem) {
        titleLabel.text = item.name
        countLabel.text = "\(item.count)"
        let rounded = (100.0*item.price).rounded() / 100.0
        priceLabel.text = "€ \(rounded)"
    }
}
