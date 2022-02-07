//
//  TableViewModel+EmptyData.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/4.
//

import Foundation
import RxRelay

/// test case，
/// https://github.com/yangKJ/Rickenbacker/blob/master/Rickenbacker/Modules/DZNEmptyDataSet/EmptyViewModel.swift

fileprivate var EmptyDataContext: UInt8 = 0

public protocol EmptyViewModelProtocol {
    /// 空数据
    var isEmptyData: BehaviorRelay<Bool> { get set }
}

extension EmptyViewModelProtocol {

    public var isEmptyData: BehaviorRelay<Bool> {
        get {
            if let empty = objc_getAssociatedObject(self, &EmptyDataContext) {
                return empty as! BehaviorRelay<Bool>
            } else {
                let empty: BehaviorRelay<Bool> = BehaviorRelay(value: false)
                objc_setAssociatedObject(self, &EmptyDataContext, empty, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return empty
            }
        }
        set {
            objc_setAssociatedObject(self, &EmptyDataContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension ViewModel: EmptyViewModelProtocol { }
