//
//  DZNEmptyDataSetBridge.swift
//  Rickenbacker
//
//  Created by Condy on 2022/5/20.
//

///`DZNEmptyDataSet`文档
/// https://github.com/dzenbot/DZNEmptyDataSet
/// https://github.com/Xiaoye220/EmptyDataSet-Swift

import DZNEmptyDataSet

final class DZNEmptyDataSetBridge: NSObject {
    
    let viewModel: ViewModelEmptiable
    var didTapContentView: (() -> Void)?
    var didTapDataButton:  (() -> Void)?
    
    // 解决闭环圈和分开操作的问题
    var sourceCallback: (() -> DZNEmptyDataSetSourceable?)?
    var delegateCallback: (() -> DZNEmptyDataSetDelegateable?)?
    
    init(with scrollView: UIScrollView, viewModel: ViewModelEmptiable) {
        self.viewModel = viewModel
        super.init()
        scrollView.emptyDataSetSource = self
        scrollView.emptyDataSetDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DZNEmptyDataSetBridge: DZNEmptyDataSetSource {
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        guard let source = sourceCallback?() else { return nil }
        return source.DZNEmptyDataSetImage(scrollView: scrollView)
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        guard let source = sourceCallback?() else { return nil }
        return source.DZNEmptyDataSetTitle(scrollView: scrollView)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        guard let source = sourceCallback?() else { return nil }
        return source.DZNEmptyDataSetDescription(scrollView: scrollView)
    }
    
    func imageTintColor(forEmptyDataSet scrollView: UIScrollView) -> UIColor? {
        guard let source = sourceCallback?() else { return nil }
        return source.DZNEmptyDataSetImageTintColor(scrollView: scrollView)
    }
    
    func imageAnimation(forEmptyDataSet scrollView: UIScrollView) -> CAAnimation? {
        guard let source = sourceCallback?() else { return nil }
        return source.DZNEmptyDataSetImageAnimation(scrollView: scrollView)
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? {
        guard let source = sourceCallback?() else { return nil }
        return source.DZNEmptyDataSetButtonTitle(scrollView: scrollView, for: state)
    }
    
    func buttonImage(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> UIImage? {
        guard let source = sourceCallback?() else { return nil }
        return source.DZNEmptyDataSetButtonImage(scrollView: scrollView, for: state)
    }
    
    func buttonBackgroundImage(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> UIImage? {
        guard let source = sourceCallback?() else { return nil }
        return source.DZNEmptyDataSetButtonBackgroundImage(scrollView: scrollView, for: state)
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView) -> UIColor {
        guard let source = sourceCallback?() else { return UIColor.clear }
        return source.DZNEmptyDataSetBackgroundColor(scrollView: scrollView)
    }
    
    func customView(forEmptyDataSet scrollView: UIScrollView) -> UIView? {
        guard let source = sourceCallback?() else { return nil }
        return source.DZNEmptyDataSetCustomView(scrollView: scrollView)
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        guard let source = sourceCallback?() else { return 0 }
        return source.DZNEmptyDataSetVerticalOffset(scrollView: scrollView)
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        guard let source = sourceCallback?() else { return 11 }
        return source.DZNEmptyDataSetSpaceHeight(scrollView: scrollView)
    }
}

extension DZNEmptyDataSetBridge: DZNEmptyDataSetDelegate {
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return viewModel.isEmptyData.value
    }
    
    func emptyDataSet(_ scrollView: UIScrollView, didTap view: UIView) {
        if let tap = didTapContentView { tap() }
    }
    
    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
        if let tap = didTapDataButton { tap() }
    }
    
    func emptyDataSetShouldFade(in scrollView: UIScrollView) -> Bool {
        guard let delegate = delegateCallback?() else { return true }
        return delegate.DZNEmptyDataSetShouldFadeIn(scrollView)
    }
    
    func emptyDataSetShouldBeForced(toDisplay scrollView: UIScrollView) -> Bool {
        guard let delegate = delegateCallback?() else { return false }
        return delegate.DZNEmptyDataSetShouldBeForcedToDisplay(scrollView)
    }
    
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView) -> Bool {
        guard let delegate = delegateCallback?() else { return true }
        return delegate.DZNEmptyDataSetShouldAllowTouch(scrollView)
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        guard let delegate = delegateCallback?() else { return false }
        return delegate.DZNEmptyDataSetShouldAllowScroll(scrollView)
    }
    
    func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView) -> Bool {
        guard let delegate = delegateCallback?() else { return false }
        return delegate.DZNEmptyDataSetShouldAnimateImageView(scrollView)
    }
    
    func emptyDataSetWillAppear(_ scrollView: UIScrollView) {
        guard let delegate = delegateCallback?() else { return }
        delegate.DZNEmptyDataSetWillAppear(scrollView)
    }
    
    func emptyDataSetDidAppear(_ scrollView: UIScrollView) {
        guard let delegate = delegateCallback?() else { return }
        delegate.DZNEmptyDataSetDidAppear(scrollView)
    }
    
    func emptyDataSetWillDisappear(_ scrollView: UIScrollView) {
        guard let delegate = delegateCallback?() else { return }
        delegate.DZNEmptyDataSetWillDisappear(scrollView)
    }
    
    func emptyDataSetDidDisappear(_ scrollView: UIScrollView) {
        guard let delegate = delegateCallback?() else { return }
        delegate.DZNEmptyDataSetDidDisappear(scrollView)
    }
}
