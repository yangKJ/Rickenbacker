//
//  ViewModelEmptiable.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/4.
//

import Foundation
import RxCocoa

/// 参考用例
/// https://github.com/yangKJ/Rickenbacker/blob/master/Rickenbacker/Modules/DZNEmptyDataSet/EmptyViewModel.swift

public protocol ViewModelEmptiable {
    /// 空数据
    var isEmptyData: BehaviorRelay<Bool> { get set }
}

extension ViewModelEmptiable {
    
    public var isEmptyData: BehaviorRelay<Bool> {
        get {
            if let empty = objc_getAssociatedObject(self, &DZNEmptyExtensionKeys.isEmptyDataContext) {
                return empty as! BehaviorRelay<Bool>
            } else {
                let empty: BehaviorRelay<Bool> = BehaviorRelay(value: false)
                objc_setAssociatedObject(self, &DZNEmptyExtensionKeys.isEmptyDataContext, empty, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return empty
            }
        }
        set {
            objc_setAssociatedObject(self, &DZNEmptyExtensionKeys.isEmptyDataContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
