//
//  SwipeableViewDelegate.swift
//  Swipeable-View-Stack
//
//  Created by Phill Farrugia on 10/21/17.
//  Copyright © 2017 Phill Farrugia. All rights reserved.
//

import Foundation

protocol SwipeableViewDelegate: class {

    func didTap(view: SwipeableView)

    func didBeginSwipe(onView view: SwipeableView)

    func didEndSwipe(onView view: SwipeableView)

}
