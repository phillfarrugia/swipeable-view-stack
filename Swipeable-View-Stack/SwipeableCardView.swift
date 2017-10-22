//
//  SwipeableStackView.swift
//  Swipeable-View-Stack
//
//  Created by Phill Farrugia on 10/21/17.
//  Copyright © 2017 Phill Farrugia. All rights reserved.
//

import UIKit

class SwipeableCardView: UIView, SwipeableViewDelegate {

    static let horizontalInset: CGFloat = 12.0

    static let verticalInset: CGFloat = 12.0

    var dataSource: SwipeableCardViewDataSource? {
        didSet {
            reloadData()
        }
    }

    var delegate: SwipeableCardViewDelegate?

    private var visibleCardViews: [SwipeableCardViewCard] {
        return subviews as? [SwipeableCardViewCard] ?? []
    }

    fileprivate var remainingCards: Int = 0

    static let numberOfVisibleCards: Int = 3

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }

    func reloadData() {
        removeAllCardViews()
        guard let dataSource = dataSource else {
            return
        }

        let numberOfCards = dataSource.numberOfCards()
        remainingCards = numberOfCards

        for index in 0..<min(numberOfCards, 3) {
            addCardView(cardView: dataSource.card(forItemAtIndex: index), atIndex: index)
        }

        setNeedsLayout()
    }

    private func addCardView(cardView: SwipeableCardViewCard, atIndex index: Int) {
        cardView.delegate = self
        setFrame(forCardView: cardView, atIndex: index)
        insertSubview(cardView, at: 0)
        remainingCards -= 1
        cardView.backgroundColor = generateRandomColor()
    }

    private func removeAllCardViews() {
        for cardView in visibleCardViews {
            cardView.removeFromSuperview()
        }
    }

    private func generateRandomColor() -> UIColor {
        let hue: CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation: CGFloat = CGFloat(arc4random() % 128) / 256 + 1.0 // from 0.5 to 1.0 to stay away from white
        let brightness: CGFloat = CGFloat(arc4random() % 128) / 256 + 1.0 // from 0.5 to 1.0 to stay away from black
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }

    private func setFrame(forCardView cardView: SwipeableCardViewCard, atIndex index: Int) {
        var cardViewFrame = bounds
        let horizontalInset = (CGFloat(index) * SwipeableCardView.horizontalInset)
        let verticalInset = CGFloat(index) * SwipeableCardView.verticalInset

        cardViewFrame.size.width -= 2 * horizontalInset
        cardViewFrame.origin.x += horizontalInset
        cardViewFrame.origin.y += verticalInset

        cardView.frame = cardViewFrame
    }

}

// MARK: - SwipeableViewDelegate

extension SwipeableCardView {

    func didTap(view: SwipeableView) {
        // Tell Delegate Card was Tapped
    }

    func didBeginSwipe(onView view: SwipeableView) {
        // React to Swipe Began?
    }

    func didEndSwipe(onView view: SwipeableView) {
        guard let dataSource = dataSource else {
            return
        }
        view.removeFromSuperview()

        if remainingCards > SwipeableCardView.numberOfVisibleCards {
            let newIndex = (dataSource.numberOfCards() - remainingCards) + 1
            addCardView(cardView: dataSource.card(forItemAtIndex: newIndex), atIndex: 2)
            
            for (cardIndex, cardView) in visibleCardViews.reversed().enumerated() {
                UIView.animate(withDuration: 0.2, animations: {
                    self.setFrame(forCardView: cardView, atIndex: cardIndex)
                })
            }

        }
    }

}
