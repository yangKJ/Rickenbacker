//
//  DZNEmptyDataSetable+Default.swift
//  Rickenbacker
//
//  Created by Condy on 2022/5/20.
//

import Foundation

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
