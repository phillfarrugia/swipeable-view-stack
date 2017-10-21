//
//  SwipeableView.swift
//  Swipeable-View-Stack
//
//  Created by Phill Farrugia on 10/21/17.
//  Copyright © 2017 Phill Farrugia. All rights reserved.
//

import UIKit

class SwipeableView: UIView, UIGestureRecognizerDelegate {

    private var panGestureRecognizer: UIPanGestureRecognizer?

    private var panGestureTranslation: CGPoint = .zero

    // MARK: Drag Animation Settings

    static var maximumRotation: CGFloat = 1.0

    static var rotationAngle: CGFloat = CGFloat(Double.pi) / 10.0

    static var animationDirectionY: CGFloat = 1.0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGestureRecognizers()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGestureRecognizers()
    }

    deinit {
        if let panGestureRecognizer = panGestureRecognizer {
            removeGestureRecognizer(panGestureRecognizer)
        }
    }

    private func setupGestureRecognizers() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(SwipeableView.panGestureRecognized(_:)))
        panGestureRecognizer.delegate = self
        self.panGestureRecognizer = panGestureRecognizer
        addGestureRecognizer(panGestureRecognizer)
    }

    @objc private func panGestureRecognized(_ gestureRecognizer: UIPanGestureRecognizer) {
        panGestureTranslation = gestureRecognizer.translation(in: self)

        switch gestureRecognizer.state {
        case .began:
            let initialTouchPoint = gestureRecognizer.location(in: self)
            let newAnchorPoint = CGPoint(x: initialTouchPoint.x / bounds.width, y: initialTouchPoint.y / bounds.height)
            let oldPosition = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)
            let newPosition = CGPoint(x: bounds.size.width * newAnchorPoint.x, y: bounds.size.height * newAnchorPoint.y)
            layer.anchorPoint = newAnchorPoint
            layer.position = CGPoint(x: layer.position.x - oldPosition.x + newPosition.x, y: layer.position.y - oldPosition.y + newPosition.y)

            // TODO: Remove any animations currently applied

            layer.rasterizationScale = UIScreen.main.scale
            layer.shouldRasterize = true
        case .changed:
            let rotationStrength = min(panGestureTranslation.x / frame.width, SwipeableView.maximumRotation)
            let rotationAngle = SwipeableView.animationDirectionY * SwipeableView.rotationAngle * rotationStrength

            var transform = CATransform3DIdentity
            transform = CATransform3DRotate(transform, rotationAngle, 0, 0, 1)
            transform = CATransform3DTranslate(transform, panGestureTranslation.x, panGestureTranslation.y, 0)
            layer.transform = transform
        case .ended:
            break
        default:
            layer.shouldRasterize = false
            break
        }
    }

}

// MARK: - UIGestureRecognizerDelegate

extension SwipeableView {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }

}
