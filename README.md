# Rickenbacker

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat&colorA=28a745&&colorB=4E4E4E)](https://github.com/yangKJ/Rickenbacker)
[![Releases Compatible](https://img.shields.io/github/release/yangKJ/Rickenbacker.svg?style=flat&label=Releases&colorA=28a745&&colorB=4E4E4E)](https://github.com/yangKJ/Rickenbacker/releases)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Rickenbacker.svg?style=flat&label=CocoaPods&colorA=28a745&&colorB=4E4E4E)](https://cocoapods.org/pods/Rickenbacker)
[![Platform](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS%20%7C%20watchOS-4E4E4E.svg?colorA=28a745)](#installation)

<font color=red>**👌. MVVM + RxSwift + CTMediatror + MJRefresh + DZNEmptyDataSet + SkeletonView**</font>

-------

English | [**简体中文**](README_CN.md)

This is a set of infrastructure based on MVVM + RxSwift

## Features
At the moment, the most important features of [Rickenbacker](https://github.com/yangKJ/Rickenbacker) can be summarized as follows:

### Adapter
This module is mainly to encapsulate the base class.

- [BaseViewController](https://github.com/yangKJ/Rickenbacker/blob/master/Sources/Adapter/BaseViewController.swift): Support oc base class, public part.
- [VMTableViewController](https://github.com/yangKJ/Rickenbacker/blob/master/Sources/Adapter/VMTableViewController.swift): List base class, internally responsive processing.
- [VMViewController](https://github.com/yangKJ/Rickenbacker/blob/master/Sources/Adapter/VMViewController.swift): You need to specify `ViewModel` or its subclasses as generics.
- [ViewModel](https://github.com/yangKJ/Rickenbacker/blob/master/Sources/Adapter/ViewModel.swift): Basic view model, Subclasses must inherit.

### CatHome
Resource module, which mainly deals with image resource and text resource reading.

- Read image resource: 

```
R.image("base_black_back")
```

- Read text resource: 

```
R.text("base_empty_title")
```

- Read color resource:

```
R.color("background")
```

### BeeBox
Mainly collect [RxSwift](https://github.com/ReactiveX/RxSwift) related useful method classes, etc.

### CTMediatror
This module mainly solves the cocoapods problem encountered by Swift using this componentized solution.

### HBDNavigationBar
This module is based on [HBDNavigationBar](https://github.com/listenzz/HBDNavigationBar) secondary encapsulation of the underlying basic Navigation.

### MJRefresh
This module is based on the refresh function of [MJRefresh](https://github.com/CoderMJLee/MJRefresh) encapsulated UITableView.

- Inject refresh function, you only need to simply implement the `ViewModelHeaderable` protocol
- Inject load more functions, just simply implement the `ViewModelFooterable` protocol

Test case:

```swift
extension MJRefreshViewModel: ViewModelHeaderable, ViewModelFooterable {
    
    var enterBeginRefresh: Bool {
        return false
    }
    // Automatic non-sensing pull-up refresh function
    var footer: MJRefreshFooter {
        let footer = MJRefreshAutoFooter()
        footer.triggerAutomaticallyRefreshPercent = -5
        return footer
    }
}
```

> Remarks: Of course, you can also customize `header` and `footer` according to your needs.

### DZNEmptyDataSet
This module is based on the empty data display function of the [DZNEmptyDataSet](https://github.com/dzenbot/DZNEmptyDataSet) package UITableView.

- To inject empty data display function, you only need to simply implement the `ViewModelEmptiable` protocol

Test case:

```swift
class EmptyViewModel: ViewModel, ViewModelEmptiable, ViewModelHeaderable {
    
    let dataSource: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    func loadData() {
        
        let driver = NetworkService().randomResult().asObservable()
        
        driver.bind(to: dataSource).disposed(by: disposeBag)
        
        driver.map { $0.isEmpty }.bind(to: isEmptyData).disposed(by: disposeBag)
        
        driver.subscribe { _ in } onCompleted: {
            self.refreshSubject.onNext(.endHeaderRefresh)
        }.disposed(by: disposeBag)
    }
}
```

- Here also supports custom style design, only need to implement `DZNEmptyDataSetSourceable`or `DZNEmptyDataSetDelegateable` agreement, interfaces are directly to `DZNEmptyDataSet` do turning processing.

```swift
public typealias DZNEmptyDataSetable = DZNEmptyDataSetSourceable & DZNEmptyDataSetDelegateable

public protocol DZNEmptyDataSetSourceable {
    
    /// Asks the data source for the image of the dataset.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: An image for the dataset.
    func DZNEmptyDataSetImage(scrollView: UIScrollView) -> UIImage
    
    /// Asks the data source for the title of the dataset.
    /// The dataset uses a fixed font style by default, if no attributes are set. If you want a different font style, return a attributed string.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: An attributed string for the dataset title, combining font, text color, text pararaph style, etc.
    func DZNEmptyDataSetTitle(scrollView: UIScrollView) -> NSAttributedString?
    
    /// Asks the data source for the description of the dataset.
    /// The dataset uses a fixed font style by default, if no attributes are set. If you want a different font style, return a attributed string.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: An attributed string for the dataset description text, combining font, text color, text pararaph style, etc.
    func DZNEmptyDataSetDescription(scrollView: UIScrollView) -> NSAttributedString?
    
    /// Asks the data source for a tint color of the image dataset. Default is nil.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: A color to tint the image of the dataset.
    func DZNEmptyDataSetImageTintColor(scrollView: UIScrollView) -> UIColor?
    
    /// Asks the data source for the image animation of the dataset.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: image animation
    func DZNEmptyDataSetImageAnimation(scrollView: UIScrollView) -> CAAnimation?
    
    /// Asks the data source for the title to be used for the specified button state.
    /// The dataset uses a fixed font style by default, if no attributes are set. If you want a different font style, return a attributed string.
    /// - Parameters:
    ///   - scrollView: A scrollView subclass informing the data source.
    ///   - state: The state that uses the specified title. The possible values are described in UIControlState.
    /// - Returns: An attributed string for the dataset button title, combining font, text color, text pararaph style, etc.
    func DZNEmptyDataSetButtonTitle(scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString?
    
    /// Asks the data source for the image to be used for the specified button state.
    /// This method will override buttonTitleForEmptyDataSet:forState: and present the image only without any text.
    /// - Parameters:
    ///   - scrollView: A scrollView subclass informing the data source.
    ///   - state: The state that uses the specified title. The possible values are described in UIControlState.
    /// - Returns: An image for the dataset button imageview.
    func DZNEmptyDataSetButtonImage(scrollView: UIScrollView, for state: UIControl.State) -> UIImage?
    
    /// Asks the data source for a background image to be used for the specified button state.
    /// There is no default style for this call.
    /// - Parameters:
    ///   - scrollView: A scrollView subclass informing the data source.
    ///   - state: The state that uses the specified image. The values are described in UIControlState.
    /// - Returns: An attributed string for the dataset button title, combining font, text color, text pararaph style, etc.
    func DZNEmptyDataSetButtonBackgroundImage(scrollView: UIScrollView, for state: UIControl.State) -> UIImage?
    
    /// Asks the data source for the background color of the dataset. Default is clear color.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: A color to be applied to the dataset background view.
    func DZNEmptyDataSetBackgroundColor(scrollView: UIScrollView) -> UIColor
    
    /// Asks the data source for a custom view to be displayed instead of the default views such as labels, imageview and button. Default is nil.
    /// Use this method to show an activity view indicator for loading feedback, or for complete custom empty data set.
    /// Returning a custom view will ignore -offsetForEmptyDataSet and -spaceHeightForEmptyDataSet configurations.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: The custom view.
    func DZNEmptyDataSetCustomView(scrollView: UIScrollView) -> UIView?
    
    /// Asks the data source for a offset for vertical and horizontal alignment of the content. Default is CGPointZero.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: The offset for vertical and horizontal alignment.
    func DZNEmptyDataSetVerticalOffset(scrollView: UIScrollView) -> CGFloat
    
    /// Asks the data source for a vertical space between elements. Default is 11 pts.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: The space height between elements.
    func DZNEmptyDataSetSpaceHeight(scrollView: UIScrollView) -> CGFloat
}

public protocol DZNEmptyDataSetDelegateable {
    
    /// Asks the delegate to know if the empty dataset should fade in when displayed. Default is YES.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: YES if the empty dataset should fade in.
    func DZNEmptyDataSetShouldFadeIn(_ scrollView: UIScrollView) -> Bool
    
    /// Asks the delegate to know if the empty dataset should still be displayed when the amount of items is more than 0. Default is NO
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: YES if empty dataset should be forced to display
    func DZNEmptyDataSetShouldBeForcedToDisplay(_ scrollView: UIScrollView) -> Bool
    
    /// Asks the delegate for touch permission. Default is YES.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: YES if the empty dataset receives touch gestures.
    func DZNEmptyDataSetShouldAllowTouch(_ scrollView: UIScrollView) -> Bool
    
    /// Asks the delegate for scroll permission. Default is NO.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: YES if the empty dataset is allowed to be scrollable.
    func DZNEmptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool
    
    /// Asks the delegate for image view animation permission. Default is NO.
    /// Make sure to return a valid CAAnimation object from imageAnimationForEmptyDataSet:
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: YES if the empty dataset is allowed to animate
    func DZNEmptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView) -> Bool
    
    /// Tells the delegate that the empty data set will appear.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    func DZNEmptyDataSetWillAppear(_ scrollView: UIScrollView)
    
    /// Tells the delegate that the empty data set did appear.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    func DZNEmptyDataSetDidAppear(_ scrollView: UIScrollView)
    
    /// Tells the delegate that the empty data set will disappear.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    func DZNEmptyDataSetWillDisappear(_ scrollView: UIScrollView)
    
    /// Tells the delegate that the empty data set did disappear.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    func DZNEmptyDataSetDidDisappear(_ scrollView: UIScrollView)
}
```

Test case:

```swift
// Configure empty data display information
extension DZNEmptyDataSetViewController: DZNEmptyDataSetable {
    
    func DZNEmptyDataSetImage(scrollView: UIScrollView) -> UIImage {
        return R.image("base_network_error_black")
    }
    
    func DZNEmptyDataSetImageTintColor(scrollView: UIScrollView) -> UIColor? {
        return UIColor.red
    }
    
    func DZNEmptyDataSetTitle(scrollView: UIScrollView) -> NSAttributedString? {
        NSAttributedString(string: R.text("TEXT"))
    }
    
    func DZNEmptyDataSetDescription(scrollView: UIScrollView) -> NSAttributedString? {
        NSAttributedString(string: R.text("测试网络异常展示"))
    }
    
    func DZNEmptyDataSetVerticalOffset(scrollView: UIScrollView) -> CGFloat {
        return -77
    }
}
```

----

### CocoaPods
- If you want use this framework.☠️

```
pod 'Rickenbacker'
```

### Remarks

> The general process is almost like this, the Demo is also written in great detail, you can check it out for yourself.🎷
>
> [**RickenbackerDemo**](https://github.com/yangKJ/Rickenbacker)
>
> Tip: If you find it helpful, please help me with a star. If you have any questions or needs, you can also issue.
>
> Thanks.🎇

### About the author
- 🎷 **E-mail address: [yangkj310@gmail.com](yangkj310@gmail.com) 🎷**
- 🎸 **GitHub address: [yangKJ](https://github.com/yangKJ) 🎸**

-----

### License
Rickenbacker is available under the [MIT](LICENSE) license. See the [LICENSE](LICENSE) file for more info.

-----
