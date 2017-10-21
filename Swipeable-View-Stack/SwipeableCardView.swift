//
//  SwipeableStackView.swift
//  Swipeable-View-Stack
//
//  Created by Phill Farrugia on 10/21/17.
//  Copyright © 2017 Phill Farrugia. All rights reserved.
//

import UIKit

class SwipeableCardView: UIView {

    static let horizontalInset: CGFloat = 12.0

    static let verticalInset: CGFloat = 12.0

    var dataSource: SwipeableCardViewDataSource? {
        didSet {
            reloadData()
        }
    }

    private var cardViews: [SwipeableCardViewCard] = []

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

        for index in 0..<dataSource.numberOfCards() {
            addCardView(cardView: dataSource.card(forItemAtIndex: index), atIndex: index)
        }

        setNeedsLayout()
    }

    private func addCardView(cardView: SwipeableCardViewCard, atIndex index: Int) {
        var cardViewFrame = bounds
        let horizontalInset = (CGFloat(index) * SwipeableCardView.horizontalInset)
        let verticalInset = CGFloat(index) * SwipeableCardView.verticalInset

        cardViewFrame.size.width -= 2 * horizontalInset
        cardViewFrame.origin.x += horizontalInset
        cardViewFrame.origin.y += verticalInset

        cardView.frame = cardViewFrame
        insertSubview(cardView, at: 0)
        cardViews.append(cardView)
        cardView.backgroundColor = generateRandomColor() // Temporary
    }

    private func removeAllCardViews() {
        for cardView in cardViews {
            cardView.removeFromSuperview()
        }
        cardViews = []
    }

    private func generateRandomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 1.0 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 1.0 // from 0.5 to 1.0 to stay away from black
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }

}
