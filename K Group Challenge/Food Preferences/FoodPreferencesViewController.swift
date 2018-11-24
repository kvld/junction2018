//
//  FoodPreferencesViewController.swift
//  K Group Challenge
//
//  Created by Ostrenkiy on 24/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import UIKit
import CenteredCollectionView

struct FoodItem {
    var title: String
    var emoji: String
}

class FoodPreferencesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var foodItems = [
        FoodItem(title: "Milk", emoji: "🥛"),
        FoodItem(title: "Banana", emoji: "🍌"),
        FoodItem(title: "Mushroom", emoji: "🍄"),
        FoodItem(title: "Meat", emoji: "🥩"),
        FoodItem(title: "Cheese", emoji: "🧀")
    ]
    
    // The width of each cell with respect to the screen.
    // Can be a constant or a percentage.
    let cellPercentWidth: CGFloat = 0.5
    
    // A reference to the `CenteredCollectionViewFlowLayout`.
    // Must be aquired from the IBOutlet collectionView.
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "FoodItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FoodItemCollectionViewCell")

        
        // Get the reference to the `CenteredCollectionViewFlowLayout` (REQURED STEP)
        centeredCollectionViewFlowLayout = collectionView.collectionViewLayout as! CenteredCollectionViewFlowLayout
        
        // Modify the collectionView's decelerationRate (REQURED STEP)
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        // Assign delegate and data source
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Configure the required item size (REQURED STEP)
        centeredCollectionViewFlowLayout.itemSize = CGSize(
            width: view.bounds.width * cellPercentWidth,
            height: collectionView.bounds.height
        )
        
        // Configure the optional inter item spacing (OPTIONAL STEP)
        centeredCollectionViewFlowLayout.minimumLineSpacing = 20
        
        // Get rid of scrolling indicators
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
}

extension FoodPreferencesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodItemCollectionViewCell", for: indexPath) as? FoodItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = foodItems[indexPath.item]
        cell.update(foodItem: item)
        return cell
    }
}

