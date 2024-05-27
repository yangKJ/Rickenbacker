//
//  ViewEmptiable.swift
//  Rickenbacker
//
//  Created by 小马哥 on 2024/5/25.
//

import Foundation
import RxSwift
import DZNEmptyDataSet

public protocol ViewEmptiable: EmptyDataTap {
    var emptyScrollView: UIScrollView { get }
    var emptyViewModel: ViewModelEmptiable { get }
    func setupOptionalEmptyData()
}

extension ViewEmptiable where Self: UIViewController {
    /// 配置空数据
    public func setupOptionalEmptyData() {
        guard let vm = emptyViewModel as? ViewModelEmptiable else { 
            return
        }
        
        let source: DZNEmptyDataSetSourceable? = self as? DZNEmptyDataSetSourceable
        let delegate: DZNEmptyDataSetDelegateable? = self as? DZNEmptyDataSetDelegateable
        if source != nil || delegate != nil {
            self.DZNEmptyBridge.didTapContentView = {
                self.emptyDataSetViewTap.onNext(())
            }
            self.DZNEmptyBridge.didTapDataButton = {
                self.emptyDataSetButtonTap.onNext(())
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
        
        vm.isEmptyData.subscribe { [weak self] empty in
            guard let isEmpty = empty.element, isEmpty else {
                return
            }
            self?.emptyScrollView.reloadEmptyDataSet()
        }.disposed(by: self._disposeBag)
    }
    
    private var _disposeBag: DisposeBag {
        get {
            return self.synchronizedBag {
                if let disposeObject = objc_getAssociatedObject(self, &DZNEmptyExtensionKeys.ViewEmptiableDisposeBagContext) as? DisposeBag {
                    return disposeObject
                }
                let disposeObject = DisposeBag()
                objc_setAssociatedObject(self, &DZNEmptyExtensionKeys.ViewEmptiableDisposeBagContext, disposeObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return disposeObject
            }
        }
        set {
            self.synchronizedBag {
                objc_setAssociatedObject(self, &DZNEmptyExtensionKeys.ViewEmptiableDisposeBagContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    private func synchronizedBag<T>(_ action: () -> T) -> T {
        objc_sync_enter(self)
        let result = action()
        objc_sync_exit(self)
        return result
    }
    
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
            DZNEmptyDataSetBridge(with: emptyScrollView, viewModel: emptyViewModel as! ViewModelEmptiable)
        }
    }
}
