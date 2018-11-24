//
//  RecipesViewController.swift
//  K Group Challenge
//
//  Created by Vladislav Kiryukhin on 24/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import UIKit
import CenteredCollectionView

final class RecipesViewController: UIViewController {
    private static let cellPercentWidth: CGFloat = 0.7

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var weekStackView: UIStackView!

    private var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!

    private let daysTitles = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupCollectionView()
        self.setupDaysSwitch()
    }

    private func setupCollectionView() {
        self.centeredCollectionViewFlowLayout = (collectionView.collectionViewLayout
            as! CenteredCollectionViewFlowLayout)
        self.collectionView.decelerationRate = .fast

        self.collectionView.register(
            UINib(nibName: "RecipeCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: RecipeCollectionViewCell.reuseID
        )
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        self.centeredCollectionViewFlowLayout.itemSize = CGSize(
            width: view.bounds.width * RecipesViewController.cellPercentWidth,
            height: collectionView.bounds.height
        )

        self.centeredCollectionViewFlowLayout.sectionInset = .zero
        self.centeredCollectionViewFlowLayout.minimumInteritemSpacing = 0
        self.centeredCollectionViewFlowLayout.minimumLineSpacing = 20
    }

    private func setupDaysSwitch() {
        self.daysTitles.forEach { title in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.addTarget(
                self,
                action: #selector(self.selectDay(_:)),
                for: .touchUpInside
            )
            self.weekStackView.addArrangedSubview(button)
        }

        (self.weekStackView.arrangedSubviews.first as? UIButton)?.isSelected = true
    }

    @objc
    private func selectDay(_ sender: UIButton) {
        for view in self.weekStackView.arrangedSubviews {
            (view as? UIButton)?.isSelected = view === sender
        }
    }
}

extension RecipesViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 6
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecipeCollectionViewCell.reuseID,
            for: indexPath
        ) as! RecipeCollectionViewCell
        return cell
    }
}

extension RecipesViewController: UICollectionViewDelegate {

}
