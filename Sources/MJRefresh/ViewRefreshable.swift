//
//  ViewRefreshable.swift
//  Rickenbacker
//
//  Created by Condy on 2024/5/27.
//

import Foundation
import RxSwift
import RxCocoa
import MJRefresh

public protocol ViewRefreshable: RefreshingSubject {
    var refreshScrollView: UIScrollView { get }
    var refreshViewModel: ViewModelRefreshable { get }
    func setupOptionalRefresh()
}

fileprivate var ViewRefreshableDisposeBagContext: UInt8 = 0

extension ViewRefreshable where Self: UIViewController {
    /// 配置刷新相关
    public func setupOptionalRefresh() {
        guard let viewModel = refreshViewModel as? ViewModelRefreshable else {
            return
        }
        
        if let header = viewModel as? ViewModelHeaderable {
            refreshScrollView.mj_header = header.header
            if header.enterBeginRefresh {
                refreshScrollView.mj_header?.beginRefreshing()
            }
            refreshScrollView.mj_header?.rx.refreshing
                .subscribe(onNext: { [weak self] _ in
                    viewModel.refreshSubject.onNext(.resetNomoreData)
                    self?.headerRefreshing.onNext(())
                }).disposed(by: self.refreshDisposeBag)
        }
        
        if let footer = viewModel as? ViewModelFooterable {
            refreshScrollView.mj_footer = footer.footer
            refreshScrollView.mj_footer?.rx.refreshing
                .subscribe(onNext: { [weak self] _ in
                    self?.footerRefreshing.onNext(())
                }).disposed(by: self.refreshDisposeBag)
        }
        
        /// 绑定下拉与上拉状态
        viewModel.refreshSubject.bind(to: refreshScrollView.rx.refreshStatus).disposed(by: self.refreshDisposeBag)
    }
    
    private var refreshDisposeBag: DisposeBag {
        get {
            return self.synchronizedBag {
                if let disposeObject = objc_getAssociatedObject(self, &ViewRefreshableDisposeBagContext) as? DisposeBag {
                    return disposeObject
                }
                let disposeObject = DisposeBag()
                objc_setAssociatedObject(self, &ViewRefreshableDisposeBagContext, disposeObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return disposeObject
            }
        }
        set {
            self.synchronizedBag {
                objc_setAssociatedObject(self, &ViewRefreshableDisposeBagContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    private func synchronizedBag<T>(_ action: () -> T) -> T {
        objc_sync_enter(self)
        let result = action()
        objc_sync_exit(self)
        return result
    }
}
