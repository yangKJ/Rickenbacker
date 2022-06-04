//
//  BaseScrollViewController+EmptyData.swift
//  Rickenbacker
//
//  Created by Condy on 2022/5/20.
//

import RxSwift
import RxCocoa
import DZNEmptyDataSet

extension BaseScrollViewController: EmptyDataTap {
    
    @_dynamicReplacement(for: setupSubEmptyData())
    private func swizzled_setupSubEmptyData() {
        setupSubEmptyData()
        setupEmptyData()
    }
    
    /// 配置空数据
    private final func setupEmptyData() {
        
        guard let vm = viewModel as? ViewModelEmptiable else { return }
        
        if self is DZNEmptyDataSetSourceable {
            self.scrollView.emptyDataSetSource = self
        }
        
        if self is DZNEmptyDataSetDelegateable {
            self.scrollView.emptyDataSetDelegate = self
        }
        
        vm.isEmptyData.subscribe { [weak self] (empty) in
            guard let `self` = self, let boo = empty.element, boo else { return }
            self.scrollView.reloadEmptyDataSet()
        }.disposed(by: disposeBag)
    }
}

extension BaseScrollViewController: DZNEmptyDataSetSource {
    
    public func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        guard let source = self as? DZNEmptyDataSetSourceable else { return nil }
        return source.DZNEmptyDataSetImage(scrollView: scrollView)
    }
    
    public func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        guard let source = self as? DZNEmptyDataSetSourceable else { return nil }
        return source.DZNEmptyDataSetTitle(scrollView: scrollView)
    }
    
    public func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        guard let source = self as? DZNEmptyDataSetSourceable else { return nil }
        return source.DZNEmptyDataSetDescription(scrollView: scrollView)
    }
    
    public func imageTintColor(forEmptyDataSet scrollView: UIScrollView) -> UIColor? {
        guard let source = self as? DZNEmptyDataSetSourceable else { return nil }
        return source.DZNEmptyDataSetImageTintColor(scrollView: scrollView)
    }
    
    public func imageAnimation(forEmptyDataSet scrollView: UIScrollView) -> CAAnimation? {
        guard let source = self as? DZNEmptyDataSetSourceable else { return nil }
        return source.DZNEmptyDataSetImageAnimation(scrollView: scrollView)
    }
    
    public func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? {
        guard let source = self as? DZNEmptyDataSetSourceable else { return nil }
        return source.DZNEmptyDataSetButtonTitle(scrollView: scrollView, for: state)
    }
    
    public func buttonImage(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> UIImage? {
        guard let source = self as? DZNEmptyDataSetSourceable else { return nil }
        return source.DZNEmptyDataSetButtonImage(scrollView: scrollView, for: state)
    }
    
    public func buttonBackgroundImage(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> UIImage? {
        guard let source = self as? DZNEmptyDataSetSourceable else { return nil }
        return source.DZNEmptyDataSetButtonBackgroundImage(scrollView: scrollView, for: state)
    }
    
    public func backgroundColor(forEmptyDataSet scrollView: UIScrollView) -> UIColor {
        guard let source = self as? DZNEmptyDataSetSourceable else { return UIColor.clear }
        return source.DZNEmptyDataSetBackgroundColor(scrollView: scrollView)
    }
    
    public func customView(forEmptyDataSet scrollView: UIScrollView) -> UIView? {
        guard let source = self as? DZNEmptyDataSetSourceable else { return nil }
        return source.DZNEmptyDataSetCustomView(scrollView: scrollView)
    }
    
    public func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        guard let source = self as? DZNEmptyDataSetSourceable else { return 0 }
        return source.DZNEmptyDataSetVerticalOffset(scrollView: scrollView)
    }
    
    public func spaceHeight(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        guard let source = self as? DZNEmptyDataSetSourceable else { return 11 }
        return source.DZNEmptyDataSetSpaceHeight(scrollView: scrollView)
    }
}

extension BaseScrollViewController: DZNEmptyDataSetDelegate {
    
    public func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        guard let vm = viewModel as? ViewModelEmptiable else { return true }
        return vm.isEmptyData.value
    }
    
    public func emptyDataSet(_ scrollView: UIScrollView, didTap view: UIView) {
        self.emptyDataSetViewTap.onNext(())
    }
    
    public func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
        self.emptyDataSetButtonTap.onNext(())
    }
    
    public func emptyDataSetShouldFade(in scrollView: UIScrollView) -> Bool {
        guard let delegate = self as? DZNEmptyDataSetDelegateable else { return true }
        return delegate.DZNEmptyDataSetShouldFadeIn(scrollView)
    }
    
    public func emptyDataSetShouldBeForced(toDisplay scrollView: UIScrollView) -> Bool {
        guard let delegate = self as? DZNEmptyDataSetDelegateable else { return false }
        return delegate.DZNEmptyDataSetShouldBeForcedToDisplay(scrollView)
    }
    
    public func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView) -> Bool {
        guard let delegate = self as? DZNEmptyDataSetDelegateable else { return true }
        return delegate.DZNEmptyDataSetShouldAllowTouch(scrollView)
    }
    
    public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        guard let delegate = self as? DZNEmptyDataSetDelegateable else { return false }
        return delegate.DZNEmptyDataSetShouldAllowScroll(scrollView)
    }
    
    public func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView) -> Bool {
        guard let delegate = self as? DZNEmptyDataSetDelegateable else { return false }
        return delegate.DZNEmptyDataSetShouldAnimateImageView(scrollView)
    }
    
    public func emptyDataSetWillAppear(_ scrollView: UIScrollView) {
        guard let delegate = self as? DZNEmptyDataSetDelegateable else { return }
        delegate.DZNEmptyDataSetWillAppear(scrollView)
    }
    
    public func emptyDataSetDidAppear(_ scrollView: UIScrollView) {
        guard let delegate = self as? DZNEmptyDataSetDelegateable else { return }
        delegate.DZNEmptyDataSetDidAppear(scrollView)
    }
    
    public func emptyDataSetWillDisappear(_ scrollView: UIScrollView) {
        guard let delegate = self as? DZNEmptyDataSetDelegateable else { return }
        delegate.DZNEmptyDataSetWillDisappear(scrollView)
    }
    
    public func emptyDataSetDidDisappear(_ scrollView: UIScrollView) {
        guard let delegate = self as? DZNEmptyDataSetDelegateable else { return }
        delegate.DZNEmptyDataSetDidDisappear(scrollView)
    }
}
