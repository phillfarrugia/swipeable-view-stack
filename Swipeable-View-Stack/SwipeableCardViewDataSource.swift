//
//  SwipeableCardViewDataSource.swift
//  Swipeable-View-Stack
//
//  Created by Phill Farrugia on 10/21/17.
//  Copyright © 2017 Phill Farrugia. All rights reserved.
//

import UIKit

/// A DataSource for providing all of the information required
/// for SwipeableCardViewContainer to layout a series of cards.
protocol SwipeableCardViewDataSource: class {

    /// Determines the number of cards to be added into the
    /// SwipeableCardViewContainer. Not all cards will initially
    /// be visible, but as cards are swiped away new cards will
    /// appear until this number of cards is reached.
    ///
    /// - Returns: total number of cards to be shown
    func numberOfCards() -> Int

    /// Provides the Card View to be displayed within the
    /// SwipeableCardViewContainer. This view's frame will
    /// be updated depending on its current index within the stack.
    ///
    /// - Parameter index: index of the card to be displayed
    /// - Returns: card view to display
    func card(forItemAtIndex index: Int) -> SwipeableCardViewCard

    /// Provides a View to be displayed underneath all of the
    /// cards when all cards have been swiped away.
    ///
    /// - Returns: view to be displayed underneath all cards
    func viewForEmptyCards() -> UIView?

}
