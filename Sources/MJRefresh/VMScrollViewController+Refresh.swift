//
//  VMScrollViewController+Refresh.swift
//  Rickenbacker
//
//  Created by Condy on 2022/5/20.
//

@_exported import MJRefresh
import RxSwift
import RxCocoa

extension VMScrollViewController: RefreshingSubject {
    
    //    @_dynamicReplacement(for: setupScrollSubRefresh())
    //    private func swizzled_setupScrollSubRefresh() {
    //        setupScrollSubRefresh()
    //        setupOptionalRefresh()
    //    }
    
    /// 配置刷新相关
    final func setupOptionalRefresh() {
        
        guard let vm = viewModel as? ViewModelRefreshable else { return }
        
        if let header = viewModel as? ViewModelHeaderable {
            scrollView.mj_header = header.header
            if header.enterBeginRefresh {
                scrollView.mj_header?.beginRefreshing()
            }
            scrollView.mj_header?.rx.refreshing
                .subscribe(onNext: { [weak self] _ in
                    vm.refreshSubject.onNext(.resetNomoreData)
                    self?.headerRefreshing.onNext(())
                }).disposed(by: disposeBag)
        }
        
        if let footer = viewModel as? ViewModelFooterable {
            scrollView.mj_footer = footer.footer
            scrollView.mj_footer?.rx.refreshing
                .subscribe(onNext: { [weak self] _ in
                    guard let `self` = self else { return }
                    self.footerRefreshing.onNext(())
                }).disposed(by: disposeBag)
        }
        
        /// 绑定下拉与上拉状态
        vm.refreshSubject.bind(to: scrollView.rx.refreshStatus).disposed(by: disposeBag)
    }
}
