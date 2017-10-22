//
//  SwipeableCardViewDelegate.swift
//  Swipeable-View-Stack
//
//  Created by Phill Farrugia on 10/21/17.
//  Copyright © 2017 Phill Farrugia. All rights reserved.
//

import Foundation

protocol SwipeableCardViewDelegate: class {

    func didSelect(card: SwipeableCardViewCard, atIndex index: Int)

}
