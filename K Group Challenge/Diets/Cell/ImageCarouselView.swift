//
//  ImageCarouselView.swift
//  K Group Challenge
//
//  Created by Vladislav Kiryukhin on 24/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import UIKit

final class ImageCarouselView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    var currentImageIndex: Int {
        if self.scrollView.bounds.size.width == 0 {
            return 0
        }

        return Int(self.scrollView.contentOffset.x / self.scrollView.bounds.size.width)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        self.clipsToBounds = true

        func constrainToEdges(view: UIView, targetView: UIView) {
            view.topAnchor.constraint(
                equalTo: targetView.topAnchor
            ).isActive = true
            view.leadingAnchor.constraint(
                equalTo: targetView.leadingAnchor
            ).isActive = true
            view.trailingAnchor.constraint(
                equalTo: targetView.trailingAnchor
            ).isActive = true
            view.bottomAnchor.constraint(
                equalTo: targetView.bottomAnchor
            ).isActive = true
        }

        addSubview(scrollView)
        scrollView.addSubview(stackView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        constrainToEdges(view: scrollView, targetView: self)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        constrainToEdges(view: stackView, targetView: scrollView)
        stackView.heightAnchor.constraint(
            equalTo: scrollView.heightAnchor
        ).isActive = true
    }

    func set(images: [UIImage]) {
        for image in images {
            let imageView = UIImageView()
            stackView.addArrangedSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(
                equalTo: self.widthAnchor
            ).isActive = true
            imageView.heightAnchor.constraint(
                equalTo: self.heightAnchor
            ).isActive = true

            imageView.image = image
            imageView.contentMode = .scaleAspectFill
        }
    }
}
