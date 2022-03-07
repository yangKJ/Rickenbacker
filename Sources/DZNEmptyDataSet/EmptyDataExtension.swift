//
//  EmptyDataExtension.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/4.
//

///`DZNEmptyDataSet`文档
/// https://github.com/dzenbot/DZNEmptyDataSet
/// https://github.com/Xiaoye220/EmptyDataSet-Swift

import EmptyDataSet_Swift
import RxSwift
import RxCocoa

fileprivate var OpenEmptyDataContext: UInt8 = 0

extension VMTableViewController {
    
    /// 是否开启空数据功能，该字段必须在`viewDidLoad`之前设置
    /// Whether to enable the empty data function, this field must be set before `viewDidLoad`
    public var openEmptyData: Bool {
        get {
            if let status = objc_getAssociatedObject(self, &OpenEmptyDataContext) {
                return status as! Bool
            } else {
                let status: Bool = true
                objc_setAssociatedObject(self, &OpenEmptyDataContext, status, .OBJC_ASSOCIATION_ASSIGN)
                return status
            }
        }
        set {
            objc_setAssociatedObject(self, &OpenEmptyDataContext, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

extension VMTableViewController {
    
    @_dynamicReplacement(for: setupSubEmptyData())
    private func swizzled_setupSubEmptyData() {
        setupSubEmptyData()
        setupEmptyData()
    }
    
    /// 配置空数据
    private final func setupEmptyData() {
        guard self.openEmptyData else { return }
        guard self.viewModel.isKind(of: ViewModel.self) else { return }
        
        tableView.emptyDataSetDelegate = self
        
        tableView.emptyDataSetView { [weak self] emptyView in
            guard let `self` = self else { return }
            emptyView.titleLabelString(NSAttributedString(string: self.emptyDataSetTitle))
                .detailLabelString(NSAttributedString(string: self.emptyDataSetDescription))
                .image(self.emptyDataSetImage)
                .imageTintColor(self.emptyDataSetImageTintColor.value)
                .verticalOffset(self.emptyDataSetVerticalOffset)
                .shouldFadeIn(true)
                .isTouchAllowed(true)
            
            emptyView.didTapDataButton { [weak self] in
                self?.emptyDataSetButtonTap.onNext(())
            }
            emptyView.didTapContentView { [weak self] in
                self?.emptyDataSetViewTap.onNext(())
            }
        }
        
        viewModel.isEmptyData.subscribe { [weak self] (empty) in
            guard let `self` = self, let boo = empty.element, boo else { return }
            self.tableView.reloadEmptyDataSet()
        }.disposed(by: disposeBag)
    }
}

extension VMTableViewController: EmptyDataSetDelegate {
    
    public func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return self.viewModel.isEmptyData.value
    }
    
    public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return true
    }
}
