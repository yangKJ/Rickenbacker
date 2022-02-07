//
//  VMTableViewController+Refresh.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//

///`MJRefresh`文档
/// https://github.com/CoderMJLee/MJRefresh

@_exported import MJRefresh
import RxSwift
import RxCocoa

fileprivate var EnterRefreshContext: UInt8 = 0
fileprivate var OpenRefreshContext: UInt8 = 0
fileprivate var HideFooterContext: UInt8 = 0

extension VMTableViewController {
    
    /// 是否开启进入就刷新，该字段必须在`viewDidLoad`之前设置
    /// Refresh when entering or not, this field must be set before `viewDidLoad`
    public var enterBeginRefresh: Bool {
        get {
            if let status = objc_getAssociatedObject(self, &EnterRefreshContext) {
                return status as! Bool
            } else {
                let status: Bool = false
                objc_setAssociatedObject(self, &EnterRefreshContext, status, .OBJC_ASSOCIATION_ASSIGN)
                return status
            }
        }
        set {
            objc_setAssociatedObject(self, &EnterRefreshContext, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    /// 是否开启刷新功能，该字段必须在`viewDidLoad`之前设置
    /// Whether to enable the refresh function, this field must be set before `viewDidLoad`
    public var openRefresh: Bool {
        get {
            if let status = objc_getAssociatedObject(self, &OpenRefreshContext) {
                return status as! Bool
            } else {
                let status: Bool = true
                objc_setAssociatedObject(self, &OpenRefreshContext, status, .OBJC_ASSOCIATION_ASSIGN)
                return status
            }
        }
        set {
            objc_setAssociatedObject(self, &OpenRefreshContext, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    /// 是否隐藏上拉加载更多功能，该字段必须在`viewDidLoad`之前设置
    /// Whether to hide the pull-up to load more functions, this field must be set before `viewDidLoad`
    public var hideFooter: Bool {
        get {
            if let status = objc_getAssociatedObject(self, &HideFooterContext) {
                return status as! Bool
            } else {
                let status: Bool = false
                objc_setAssociatedObject(self, &HideFooterContext, status, .OBJC_ASSOCIATION_ASSIGN)
                return status
            }
        }
        set {
            objc_setAssociatedObject(self, &HideFooterContext, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

extension VMTableViewController {
    
    @_dynamicReplacement(for: setupSubRefresh())
    private func swizzled_setupSubRefresh() {
        setupSubRefresh()
        setupRefresh()
    }
    
    /// 配置刷新相关
    private final func setupRefresh() {
        guard self.openRefresh else { return }
        guard self.viewModel.isKind(of: ViewModel.self) else { return }
        
        if let _ = tableView.mj_header { } else {
            tableView.mj_header = MJRefreshNormalHeader()
            if self.enterBeginRefresh {
                tableView.mj_header?.beginRefreshing()
            }
        }
        if let _ = tableView.mj_footer { } else if self.hideFooter == false {
            tableView.mj_footer = MJRefreshBackNormalFooter()
        }
        
        tableView.mj_header?.rx.refreshing
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.viewModel.refreshSubject.onNext(.resetNomoreData)
                self.headerRefreshing.onNext(())
            }).disposed(by: disposeBag)
        
        if self.hideFooter == false {
            tableView.mj_footer?.rx.refreshing
                .asDriver()
                .drive(onNext: { [weak self] _ in
                    guard let `self` = self else { return }
                    self.footerRefreshing.onNext(())
                }).disposed(by: disposeBag)
        }
        
        /// 绑定下拉与上拉状态
        viewModel.refreshSubject.bind(to: tableView.rx.refreshStatus).disposed(by: disposeBag)
    }
}
