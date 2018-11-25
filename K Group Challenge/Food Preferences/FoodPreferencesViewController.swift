//
//  FoodPreferencesViewController.swift
//  K Group Challenge
//
//  Created by Ostrenkiy on 24/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import UIKit
import CenteredCollectionView
import PromiseKit
import SVProgressHUD

struct FoodItem {
    var title: String
    var image: UIImage
    var ids: [Int]
}

class FoodPreferencesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var foodItems = [
        FoodItem(title: "Milk", image: UIImage(named: "002-milk")!, ids: [9817, 13311, 13312, 9814, 13310, 9816, 6720, 13313, 13315]),
        FoodItem(title: "Chicken", image: UIImage(named: "003-turkey")!, ids: [5687, 5686, 5684, 7789, 10524, 10520, 5225, 5990, 5685, 9359, 5683, 5688, 10516, 9348, 11944, 7717, 9997]),
        FoodItem(title: "Mushroom", image: UIImage(named: "007-mushroom")!, ids: [5516, 8342, 8343, 13962, 13966, 11943, 11480, 14508, 8344, 13960, 11453, 13959, 8340, 8341, 5517, 13963, 13964, 13961, 11450, 12373, 13432, 6744, 13965, 13433, 8286, 6901, 10081]),
        FoodItem(title: "Pepper", image: UIImage(named: "006-chili")!, ids: [12094, 7963, 8218, 10437, 11872, 15044, 14981, 12781, 6564, 12776, 12002, 9982, 9983, 12779, 7178, 9803, 7794, 9320, 13889, 12767, 14438, 10883, 12770, 6318, 11785, 12989, 11259, 12775, 12973, 6565, 8255, 5379]),
        FoodItem(title: "Cheese", image: UIImage(named: "005-cheese")!, ids: [6726, 12322, 10464, 5487, 9112, 13899, 5598, 10465, 14423]),
        FoodItem(title: "Bread", image: UIImage(named: "004-bread")!, ids: [12429, 8105, 10456, 13945, 10458, 14886, 13944, 9395, 14524, 10457, 10454, 13628, 11760, 10475, 10480, 10472]),
    ]
    
    var selected: [Int] = [3, 3, 3, 3, 3, 3]
    
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.shared.statusBarStyle = .default
    }
    
    func collectPreferences() -> [(item: FoodItem, rank: Int)] {
        
        return foodItems.enumerated().compactMap { offset, item in
            if selected[offset] < 1 {
                return (item: item, rank: -1)
            }
            if selected[offset] > 2 {
                return (item: item, rank: 1)
            }
            return nil
        }
    }
    
    @IBAction func finishPressed(_ sender: Any) {
        let preferences = collectPreferences()
        (sender as? UIButton)?.isEnabled = false
        SVProgressHUD.show()
        Network.shared.getRecipes(ranks: preferences, dietType: .gain).done {[weak self] newDiets in
            DispatchQueue.main.async {
                (sender as? UIButton)?.isEnabled = true
                SVProgressHUD.dismiss()
            }
            print("done")
            diets = newDiets
            DispatchQueue.main.async {
                self?.performSegue(withIdentifier: "showNext", sender: nil)
            }
        }.catch { _ in
            DispatchQueue.main.async {
                (sender as? UIButton)?.isEnabled = true
                SVProgressHUD.showError(withStatus: "Operation failed")
            }
        }
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
        cell.slider.selectedSection = selected[indexPath.item]
        cell.sectionChanged = { [weak self] newSection in
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            self?.selected[indexPath.item] = newSection
        }
        return cell
    }
}

