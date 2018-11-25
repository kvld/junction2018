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
    private static let cellPercentWidth: CGFloat = 0.91

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var weekTitleStackView: UIStackView!
    @IBOutlet private weak var weekStackView: UIStackView!

    private var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!

    private let daysTitles = ["25", "26", "27", "28", "29", "30", "1"]

    private var viewModels: [RecipeViewModel] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Menu"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupCollectionView()
        self.setupDaysSwitch()

        // Mock
        self.viewModels = [
            RecipeViewModel(
                image: UIImage(named: "recipe1")!,
                title: "Recipe title 1",
                summary: "Summary summary summary summary",
                calories: "1000",
                carbohydrates: "32.1",
                fats: "7.1",
                proteins: "16.7",
                caloriesPercent: 0.5,
                carbohydratesPercent: 0.5,
                fatsPercent: 0.5,
                proteinsPercent: 0.5
            ),
            RecipeViewModel(
                image: UIImage(named: "recipe2")!,
                title: "Recipe title 2",
                summary: "Summary summary summary summary",
                calories: "1000",
                carbohydrates: "32.1",
                fats: "7.1",
                proteins: "16.7",
                caloriesPercent: 0.5,
                carbohydratesPercent: 0.5,
                fatsPercent: 0.5,
                proteinsPercent: 0.5
            ),
            RecipeViewModel(
                image: UIImage(named: "recipe3")!,
                title: "Recipe title",
                summary: "Summary summary summary summary",
                calories: "1000",
                carbohydrates: "32.1",
                fats: "7.1",
                proteins: "16.7",
                caloriesPercent: 0.5,
                carbohydratesPercent: 0.5,
                fatsPercent: 0.5,
                proteinsPercent: 0.5
            )
        ]
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

        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        self.centeredCollectionViewFlowLayout.minimumInteritemSpacing = 0
        self.centeredCollectionViewFlowLayout.minimumLineSpacing = 8
    }

    private func setupDaysSwitch() {
        self.daysTitles.forEach { title in
            let button = UIButton(type: .custom)
            button.setTitle(title, for: .normal)
            button.addTarget(
                self,
                action: #selector(self.selectDay(_:)),
                for: .touchUpInside
            )
            button.clipsToBounds = true
            button.layer.cornerRadius = 21
            button.widthAnchor.constraint(equalToConstant: 32).isActive = true

            let btnBg = UIImageView(image: UIImage(named: "gradient")!)
            button.widthAnchor.constraint(equalToConstant: 32).isActive = true
            button.heightAnchor.constraint(equalToConstant: 32).isActive = true
            button.insertSubview(btnBg, belowSubview: button.titleLabel!)

            self.weekStackView.addArrangedSubview(button)
        }

        if let button = self.weekStackView.arrangedSubviews.first as? UIButton {
            self.selectDay(button)
        }
    }

    @objc
    private func selectDay(_ sender: UIButton) {
        for view in self.weekStackView.arrangedSubviews {
            for subview in view.subviews {
                if let subview = subview as? UIImageView {
                    subview.isHidden = view !== sender
                    (view as? UIButton)?.setTitleColor(
                        view === sender ? .white : UIColor(red: 158/255, green: 171/255, blue: 190/255, alpha: 1.0),
                        for: .normal
                    )
                }
            }
        }
    }
}

extension RecipesViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return self.viewModels.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecipeCollectionViewCell.reuseID,
            for: indexPath
        ) as! RecipeCollectionViewCell
        let viewModel = self.viewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
}

extension RecipesViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let viewModel = self.viewModels[indexPath.row]

        let storyboard = UIStoryboard(name: "Recipes", bundle: nil)
        let vc = storyboard.instantiateViewController(
            withIdentifier: "DetailRecipeViewController"
        ) as! DetailRecipeViewController
        vc.configure(with: viewModel)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
