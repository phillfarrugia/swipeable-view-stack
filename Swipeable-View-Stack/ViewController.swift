//
//  ViewController.swift
//  Swipeable-View-Stack
//
//  Created by Phill Farrugia on 10/21/17.
//  Copyright © 2017 Phill Farrugia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SwipeableCardViewDataSource {

    @IBOutlet private weak var swipeableCardView: SwipeableCardView!

    override func viewDidLoad() {
        super.viewDidLoad()

        swipeableCardView.dataSource = self
    }

}

// MARK: - SwipeableCardViewDataSource

extension ViewController {

    func numberOfCards() -> Int {
        return 10
    }

    func card(forItemAtIndex index: Int) -> SwipeableCardViewCard {
        return SwipeableCardViewCard()
    }

}

