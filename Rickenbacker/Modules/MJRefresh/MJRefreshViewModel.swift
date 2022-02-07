//
//  MJRefreshViewModel.swift
//  Rickenbacker_Example
//
//  Created by Condy on 2021/10/3.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Rickenbacker

final class MJRefreshViewModel: ViewModel {
    struct Input {
        let headerRefresh: Observable<Void>
        let footerRefresh: Observable<Void>
    }
    struct Output {
        let items: Driver<[String]>
    }
}

extension MJRefreshViewModel: ViewModelType {
    
    func transform(input: Input) -> Output {
        var objects: [String] = []
        var page: Int = 1
        
        // 下拉刷新
        let refresh = input.headerRefresh.then(page = 1)
            .flatMapLatest {
                MJRefreshAPI.refresh(page).request()
            }.map { [unowned self] (items) -> [String] in
                refreshSubject.onNext(.endHeaderRefresh)
                objects = items
                return objects
            }.asDriver(onErrorJustReturn: [])
        
        // 上拉加载更多
        let more = input.footerRefresh.then(page += 1)
            .flatMapLatest {
                MJRefreshAPI.refresh(page).request()
            }.map { [unowned self] (items) -> [String] in
                if items.isEmpty {
                    refreshSubject.onNext(.endFooterRefreshWithNoData)
                } else {
                    refreshSubject.onNext(.endFooterRefresh)
                }
                objects += items
                return objects
            }.asDriver(onErrorJustReturn: [])
        
        let items = Driver.of(refresh, more).merge()
        
        // 空数据绑定
        items.map { $0.isEmpty }.asObservable().bind(to: isEmptyData).disposed(by: disposeBag)
        
        return Output(items: items)
    }
}
