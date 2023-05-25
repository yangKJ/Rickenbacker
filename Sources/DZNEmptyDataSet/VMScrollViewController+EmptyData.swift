//
//  VMScrollViewController+EmptyData.swift
//  Rickenbacker
//
//  Created by Condy on 2022/5/20.
//

import RxSwift
import RxCocoa
import DZNEmptyDataSet

extension VMScrollViewController: EmptyDataTap {
    
//    @_dynamicReplacement(for: setupScrollSubEmptyData())
//    private func swizzled_setupScrollSubEmptyData() {
//        setupScrollSubEmptyData()
//        setupOptionalEmptyData()
//    }
    
    private var DZNEmptyBridge: DZNEmptyDataSetBridge {
        func lazyInstanceBridge<T: AnyObject>(_ key: UnsafeRawPointer, createCachedBridge: () -> T) -> T {
            if let value = objc_getAssociatedObject(self, key) as? T {
                return value
            }
            let bridge = createCachedBridge()
            objc_setAssociatedObject(self, key, bridge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return bridge
        }
        return lazyInstanceBridge(&DZNEmptyExtensionKeys.emptyBridgeContext) { () -> DZNEmptyDataSetBridge in
            DZNEmptyDataSetBridge.init(with: scrollView, viewModel: viewModel as! ViewModelEmptiable)
        }
    }
    
    /// 配置空数据
    final func setupOptionalEmptyData() {
        
        guard let vm = viewModel as? ViewModelEmptiable else { return }
        
        let source: DZNEmptyDataSetSourceable? = self as? DZNEmptyDataSetSourceable
        let delegate: DZNEmptyDataSetDelegateable? = self as? DZNEmptyDataSetDelegateable
        if source != nil || delegate != nil {
            self.DZNEmptyBridge.didTapContentView = { [weak self] in
                self?.emptyDataSetViewTap.onNext(())
            }
            self.DZNEmptyBridge.didTapDataButton = { [weak self] in
                self?.emptyDataSetButtonTap.onNext(())
            }
            if source != nil {
                self.DZNEmptyBridge.sourceCallback = { [weak self] in
                    guard let weakself = self else {
                        return nil
                    }
                    return weakself as? DZNEmptyDataSetSourceable
                }
            }
            if delegate != nil {
                self.DZNEmptyBridge.delegateCallback = { [weak self] in
                    guard let weakself = self else {
                        return nil
                    }
                    return weakself as? DZNEmptyDataSetDelegateable
                }
            }
        }
        
        vm.isEmptyData.subscribe { [weak self] (empty) in
            guard let isEmpty = empty.element, isEmpty else {
                return
            }
            self?.scrollView.reloadEmptyDataSet()
        }.disposed(by: disposeBag)
    }
}
