//
//  RefreshingSubject.swift
//  Rickenbacker
//
//  Created by Condy on 2022/5/20.
//

import RxSwift
import RxCocoa

public protocol RefreshingSubject {
    
    /// 下拉刷新事件可观察序列✌️
    /// Pull down refresh event observable sequence✌️
    var headerRefreshing: PublishSubject<Void> { get set } // = PublishSubject()
    /// 上拉加载更多事件可观察序列✌️
    /// Pull up to load more event observable sequences✌️
    var footerRefreshing: PublishSubject<Void> { get set } // = PublishSubject()
}

fileprivate var HeaderRefreshingContext: UInt8 = 0
fileprivate var FooterRefreshingContext: UInt8 = 0

extension RefreshingSubject {
    
    public var headerRefreshing: PublishSubject<Void> {
        get {
            if let refresh = objc_getAssociatedObject(self, &HeaderRefreshingContext) {
                return refresh as! PublishSubject<Void>
            } else {
                let refresh: PublishSubject<Void> = PublishSubject<Void>()
                objc_setAssociatedObject(self, &HeaderRefreshingContext, refresh, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return refresh
            }
        }
        set {
            objc_setAssociatedObject(self, &HeaderRefreshingContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var footerRefreshing: PublishSubject<Void> {
        get {
            if let refresh = objc_getAssociatedObject(self, &FooterRefreshingContext) {
                return refresh as! PublishSubject<Void>
            } else {
                let refresh: PublishSubject<Void> = PublishSubject<Void>()
                objc_setAssociatedObject(self, &FooterRefreshingContext, refresh, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return refresh
            }
        }
        set {
            objc_setAssociatedObject(self, &FooterRefreshingContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
