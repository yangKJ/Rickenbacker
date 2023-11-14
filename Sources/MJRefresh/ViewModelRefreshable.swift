//
//  Refreshable.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//

import Foundation
import RxSwift

/// 参考用例
/// https://github.com/yangKJ/Rickenbacker/blob/master/Rickenbacker/Modules/MJRefresh/MJRefreshViewModel.swift

fileprivate var RefreshSubjectContext: UInt8 = 0

public protocol ViewModelRefreshable: AnyObject {
    /// 刷新状态
    var refreshSubject: BehaviorSubject<RefreshStatus> { get set }
}

extension ViewModelRefreshable {
    
    public var refreshSubject: BehaviorSubject<RefreshStatus> {
        get {
            if let status = objc_getAssociatedObject(self, &RefreshSubjectContext) {
                return status as! BehaviorSubject<RefreshStatus>
            } else {
                let status: BehaviorSubject<RefreshStatus> = BehaviorSubject(value: .none)
                objc_setAssociatedObject(self, &RefreshSubjectContext, status, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return status
            }
        }
        set {
            objc_setAssociatedObject(self, &RefreshSubjectContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
