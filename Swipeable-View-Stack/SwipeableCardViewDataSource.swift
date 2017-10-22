//
//  SwipeableCardViewDataSource.swift
//  Swipeable-View-Stack
//
//  Created by Phill Farrugia on 10/21/17.
//  Copyright © 2017 Phill Farrugia. All rights reserved.
//

import UIKit

protocol SwipeableCardViewDataSource: class {

    func numberOfCards() -> Int

    func card(forItemAtIndex index: Int) -> SwipeableCardViewCard

    func viewForEmptyCards() -> UIView?

}
