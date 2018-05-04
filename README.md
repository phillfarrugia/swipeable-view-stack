# swipeable-view-stack
A Swipeable Stack of Views similar to a popular dating app but for swiping through anything, built [for this Medium Article](https://medium.com/@phillfarrugia/building-a-tinder-esque-card-interface-5afa63c6d3db)

![Inspecting Views in Reveal](https://cdn-images-1.medium.com/max/2000/1*xNdGVZT6Y-EYTWmFYag24A.png)

## Description

Tinder pioneered an incredibly interesting and unique gesture-based interaction pattern that set the standard for many mobiles apps in the software industry today. 

One weekend I stumbled upon a Dribbble post that caught my attention, which depicted a simplified version of the Tinder-esque card interface. I decided to take the time to implement it natively in Swift and write about my process behind building the components, gestures and animations. 

This ended up being a great opportunity for me to learn a bit more about the tools available for crafting interfaces that are exciting and people love to use.

# Features

### SwipeableCardViewContainer

Interacting with this entire component is about dropping a SwipeableCardViewContainer view into your Storyboard (or code) and conforming to the SwipeableCardViewDataSource, SwipeableCardViewDelegate protocols. This container view is the view that is responsible for laying out all of the cards within itself and handling all of the underlying logic of keeping track of a series of cards. It’s designed to be quite similar to UICollectionView and UITableView which you’re likely already familiar with.

```swift
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
```

### SwipeableView

As you would’ve expected the most complex and time consuming part of implementing this component was the draggable cards. This required applying a lot of complex math (of which some I still don’t fully understand). Most of this is housed within a UIView subclass called SwipeableView.

Each card subclasses SwipeableView which uses a UIPanGestureRecognizer internally to listen for Pan gestures such as a user ‘grabbing’ a card with their finger and moving it around the screen, then flicking it or lifting their finger. Gesture Recognizers are very underrated APIs that are incredibly easy and simple to work with considering how much functionality and power they provide.

### SampleSwipeableCard

Now that we’ve implemented SwipeableView, creating custom cards that look different, contain their own content such as UILabels, UIImages and UIButtons as subviews is as easy as inheriting from SwipeableView. The subclass itself is strictly responsible for managing its own content and relies on the superclass to take care of all of the swipe-able logic that was just implemented.

I’ve created a SampleSwipeableCard subclass that contains a a UILabel for a title, and a subtitle, as well as a red UIButton with a plus icon and a UIView with a distinct background color that contains an inner UIImageView. All standard, simple and basic UIKit elements thrown onto a Xib exactly as you would expect.

In my ViewController I ensure that I’m creating a series of ViewModels for each Card, that my SampleSwipeableCard can configure itself with.


```swift
extension ViewController {

    var viewModels: [SampleSwipeableCellViewModel] {

        let hamburger = SampleSwipeableCellViewModel(title: "McDonalds",
                                                     subtitle: "Hamburger",
                                                     color: UIColor(red:0.96, green:0.81, blue:0.46, alpha:1.0),
                                                     image: #imageLiteral(resourceName: "hamburger"))

        let panda = SampleSwipeableCellViewModel(title: "Panda",
                                                  subtitle: "Animal",
                                                  color: UIColor(red:0.29, green:0.64, blue:0.96, alpha:1.0),
                                                  image: #imageLiteral(resourceName: "panda"))

        let puppy = SampleSwipeableCellViewModel(title: "Puppy",
                                                  subtitle: "Pet",
                                                  color: UIColor(red:0.29, green:0.63, blue:0.49, alpha:1.0),
                                                  image: #imageLiteral(resourceName: "puppy"))

        let poop = SampleSwipeableCellViewModel(title: "Poop",
                                                  subtitle: "Smelly",
                                                  color: UIColor(red:0.69, green:0.52, blue:0.38, alpha:1.0),
                                                  image: #imageLiteral(resourceName: "poop"))

        let robot = SampleSwipeableCellViewModel(title: "Robot",
                                                  subtitle: "Future",
                                                  color: UIColor(red:0.90, green:0.99, blue:0.97, alpha:1.0),
                                                  image: #imageLiteral(resourceName: "robot"))

        let clown = SampleSwipeableCellViewModel(title: "Clown",
                                                  subtitle: "Scary",
                                                  color: UIColor(red:0.83, green:0.82, blue:0.69, alpha:1.0),
                                                  image: #imageLiteral(resourceName: "clown"))

        return [hamburger, panda, puppy, poop, robot, clown]
    }

}
```

## Contributions

I have no immediate plans to actively work on this experiment any further. However this source code is licensed under the [MIT license](https://github.com/phillfarrugia/swipeable-view-stack/blob/master/LICENSE) which permits anyone to fork this repository and make modifications under the same license.