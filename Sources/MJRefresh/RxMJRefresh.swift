//
//  RxMJRefresh.swift
//  RxExtensionx
//
//  Created by Condy on 2021/10/2.
//  https://github.com/YangKJ/RxExtensionx

import MJRefresh
import RxSwift
import RxCocoa

public enum RefreshStatus {
    case none
    case begainHeaderRefresh, endHeaderRefresh
    case hiddendFooter, showFooter
    case endFooterRefresh, endFooterRefreshWithNoData
    case resetNomoreData
}

extension Reactive where Base: UIScrollView {
    
    /// 绑定刷新状态
    public var refreshStatus: Binder<RefreshStatus> {
        return Binder(base) { (scroll, status) in
            switch status {
            case .begainHeaderRefresh:
                scroll.mj_header?.beginRefreshing()
            case .endHeaderRefresh:
                scroll.mj_header?.endRefreshing()
            case .hiddendFooter:
                scroll.mj_footer?.isHidden = true
            case .showFooter:
                scroll.mj_footer?.isHidden = false
            case .endFooterRefresh:
                scroll.mj_footer?.endRefreshing()
            case .endFooterRefreshWithNoData:
                scroll.mj_footer?.endRefreshingWithNoMoreData()
            case .resetNomoreData:
                scroll.mj_footer?.resetNoMoreData()
            default: break
            }
        }
    }
}

fileprivate var kRxRefreshCommentKey: UInt8 = 0

extension Reactive where Base: MJRefreshComponent {
    
    /// 正在刷新事件
    public var refreshing: ControlEvent<Void> {
        let source: Observable<Void> = lazyInstanceObservable(&kRxRefreshCommentKey) { () -> Observable<()> in
            Observable.create { [weak control = self.base] observer in
                if let control = control {
                    control.refreshingBlock = {
                        observer.on(.next(()))
                    }
                } else {
                    observer.on(.completed)
                }
                return Disposables.create()
            }
            .take(until: self.deallocated)
            .share(replay: 1)
        }
        return ControlEvent(events: source)
    }
    
    /// 开始刷新
    public var beginRefreshing: Binder<Void> {
        return Binder(base) { (refresh, _) in
            refresh.beginRefreshing()
        }
    }
    
    /// 停止刷新
    public var endRefreshing: Binder<Bool> {
        return Binder(base) { (refresh, isEnd) in
            if isEnd {
                refresh.endRefreshing()
            }
        }
    }
    
    /// 是否正在刷新中
    public var isRefreshing: Binder<Bool> {
        return Binder(base) { (header, refresh) in
            if refresh && header.isRefreshing {
                return
            } else {
                refresh ? header.beginRefreshing() : header.endRefreshing()
            }
        }
    }
    
    private func lazyInstanceObservable<T: AnyObject>(_ key: UnsafeRawPointer, createCachedObservable: () -> T) -> T {
        if let value = objc_getAssociatedObject(self.base, key) as? T {
            return value
        }
        let observable = createCachedObservable()
        objc_setAssociatedObject(self.base, key, observable, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return observable
    }
}
