//
//  DZNEmptyDataSetable.swift
//  Rickenbacker
//
//  Created by Condy on 2022/5/20.
//

/// 参考用例
/// https://github.com/yangKJ/Rickenbacker/blob/master/Rickenbacker/Modules/DZNEmptyDataSet/DZNEmptyDataSetViewController.swift

import DZNEmptyDataSet

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

// 默认数据
extension DZNEmptyDataSetSourceable {
    
    public func DZNEmptyDataSetTitle(scrollView: UIScrollView) -> NSAttributedString? {
        return nil
    }
    
    public func DZNEmptyDataSetDescription(scrollView: UIScrollView) -> NSAttributedString? {
        return nil
    }
    
    public func DZNEmptyDataSetImageTintColor(scrollView: UIScrollView) -> UIColor? {
        return nil
    }
    
    public func DZNEmptyDataSetImageAnimation(scrollView: UIScrollView) -> CAAnimation? {
        return nil
    }
    
    public func DZNEmptyDataSetButtonTitle(scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? {
        return nil
    }
    
    public func DZNEmptyDataSetButtonImage(scrollView: UIScrollView, for state: UIControl.State) -> UIImage? {
        return nil
    }
    
    public func DZNEmptyDataSetButtonBackgroundImage(scrollView: UIScrollView, for state: UIControl.State) -> UIImage? {
        return nil
    }
    
    public func DZNEmptyDataSetBackgroundColor(scrollView: UIScrollView) -> UIColor {
        return UIColor.clear
    }
    
    public func DZNEmptyDataSetCustomView(scrollView: UIScrollView) -> UIView? {
        return nil
    }
    
    public func DZNEmptyDataSetVerticalOffset(scrollView: UIScrollView) -> CGFloat {
        return 0
    }
    
    public func DZNEmptyDataSetSpaceHeight(scrollView: UIScrollView) -> CGFloat {
        return 11
    }
}

extension DZNEmptyDataSetDelegateable {
    
    public func DZNEmptyDataSetShouldFadeIn(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    public func DZNEmptyDataSetShouldBeForcedToDisplay(_ scrollView: UIScrollView) -> Bool {
        return false
    }
    
    public func DZNEmptyDataSetShouldAllowTouch(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    public func DZNEmptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return false
    }
    
    public func DZNEmptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView) -> Bool {
        return false
    }
    
    public func DZNEmptyDataSetWillAppear(_ scrollView: UIScrollView) { }
    public func DZNEmptyDataSetDidAppear(_ scrollView: UIScrollView) { }
    public func DZNEmptyDataSetWillDisappear(_ scrollView: UIScrollView) { }
    public func DZNEmptyDataSetDidDisappear(_ scrollView: UIScrollView) { }
}
