//
//  SampleSwipeableCard.swift
//  Swipeable-View-Stack
//
//  Created by Phill Farrugia on 10/21/17.
//  Copyright © 2017 Phill Farrugia. All rights reserved.
//

import UIKit

class SampleSwipeableCard: SwipeableCardViewCard {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var addButton: UIView!

    @IBOutlet private weak var imageBackgroundColorView: UIView!
    @IBOutlet private weak var imageView: UIImageView!

    var viewModel: SampleSwipeableCellViewModel? {
        didSet {
            configure(forViewModel: viewModel)
        }
    }

    private func configure(forViewModel viewModel: SampleSwipeableCellViewModel?) {
        if let viewModel = viewModel {
            titleLabel.text = viewModel.title
            subtitleLabel.text = viewModel.subtitle
            imageBackgroundColorView.backgroundColor = viewModel.color
            imageView.image = viewModel.image

            addButton.layer.cornerRadius = addButton.frame.size.height/4
        }
    }

}
