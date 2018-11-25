//
//  DietsListViewController.swift
//  K Group Challenge
//
//  Created by Vladislav Kiryukhin on 24/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import UIKit

final class DietsListViewController: UIViewController {
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!

    private var viewModels: [DietViewModel] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Diets"

        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        UIApplication.shared.statusBarStyle = .lightContent
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension

        self.tableView.register(
            UINib(nibName: "DietTableViewCell", bundle: nil),
            forCellReuseIdentifier: DietTableViewCell.reuseID
        )

        // Mock
        self.viewModels = [
            DietViewModel(
                recipes: [
                    .init(
                        title: "Breakfast",
                        image: UIImage(named: "recipe1")!
                    ),
                    .init(
                        title: "Dinner",
                        image: UIImage(named: "recipe2")!
                    )
                ],
                calories: "228 kcal",
                price: "$100"
            ),
            DietViewModel(
                recipes: [
                    .init(
                        title: "Breakfast",
                        image: UIImage(named: "recipe1")!
                    ),
                    .init(
                        title: "Dinner",
                        image: UIImage(named: "recipe2")!
                    )
                ],
                calories: "1000 kcal",
                price: "$200"
            ),
            DietViewModel(
                recipes: [
                    .init(
                        title: "Breakfast",
                        image: UIImage(named: "recipe1")!
                    ),
                    .init(
                        title: "Dinner",
                        image: UIImage(named: "recipe2")!
                    )
                ],
                calories: "1000 kcal",
                price: "$300"
            )
        ]
        self.tableView.reloadData()
    }
}

extension DietsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModels.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: DietTableViewCell.reuseID,
            for: indexPath
        ) as! DietTableViewCell

        let viewModel = self.viewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
}

extension DietsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let storyboard = UIStoryboard(name: "Recipes", bundle: nil)
        let vc = storyboard.instantiateViewController(
            withIdentifier: "RecipesViewController"
        )
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
