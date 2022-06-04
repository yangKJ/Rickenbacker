//
//  VMTableViewController+EmptyData.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/4.
//

import RxSwift
import RxCocoa
import DZNEmptyDataSet

extension VMTableViewController: EmptyDataTap {
    
    @_dynamicReplacement(for: setupSubEmptyData())
    private func swizzled_setupSubEmptyData() {
        setupSubEmptyData()
        setupEmptyData()
    }
    
    /// 配置空数据
    private final func setupEmptyData() {
        
        guard let vm = viewModel as? ViewModelEmptiable else { return }
        
        let source: DZNEmptyDataSetSourceable? = self as? DZNEmptyDataSetSourceable
        let delegate: DZNEmptyDataSetDelegateable? = self as? DZNEmptyDataSetDelegateable
        if source != nil || delegate != nil {
            let bridge = self.DZNEmptyBridge
            bridge.didTapContentView = { [weak self] in
                self?.emptyDataSetViewTap.onNext(())
            }
            bridge.didTapDataButton = { [weak self] in
                self?.emptyDataSetButtonTap.onNext(())
            }
            if source != nil {
                bridge.sourceCallback = { [weak self] in
                    guard let `self` = self else { return nil }
                    return self as? DZNEmptyDataSetSourceable
                }
            }
            if delegate != nil {
                bridge.delegateCallback = { [weak self] in
                    guard let `self` = self else { return nil }
                    return self as? DZNEmptyDataSetDelegateable
                }
            }
        }
        
        vm.isEmptyData.subscribe { [weak self] (empty) in
            guard let `self` = self, let boo = empty.element, boo else { return }
            self.tableView.reloadEmptyDataSet()
        }.disposed(by: disposeBag)
    }
}

fileprivate var DZNEmptyDataContext: UInt8 = 0

extension VMTableViewController {
    
    private var DZNEmptyBridge: DZNEmptyDataSetBridge {
        return lazyInstanceObservable(&DZNEmptyDataContext) { () -> DZNEmptyDataSetBridge in
            DZNEmptyDataSetBridge(tableView, viewModel: viewModel as! ViewModelEmptiable)
        }
    }
    
    private func lazyInstanceObservable<T: AnyObject>(_ key: UnsafeRawPointer, createCachedObservable: () -> T) -> T {
        if let value = objc_getAssociatedObject(self, key) as? T {
            return value
        }
        let observable = createCachedObservable()
        objc_setAssociatedObject(self, key, observable, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return observable
    }
}
