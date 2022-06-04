//
//  CScrollViewModel.swift
//  Rickenbacker_Example
//
//  Created by Condy on 2022/6/4.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Rickenbacker

final class CScrollViewModel: ViewModel, ViewModelHeaderAndFooterable, ViewModelEmptiable {
    struct Input {
        let headerRefresh: Observable<Void>
        let footerRefresh: Observable<Void>
    }
    struct Output {
        let items: Driver<[String]>
    }
}

extension CScrollViewModel: ViewModelType {
    
    func transform(input: Input) -> Output {
        var objects: [String] = []
        var page: Int = 1
        
        // 下拉刷新
        let refresh = input.headerRefresh.then(page = 1)
            .flatMapLatest {
                MJRefreshAPI.refresh(page).request()
            }.map { [weak self] (items) -> [String] in
                self?.refreshSubject.onNext(.endHeaderRefresh)
                //objects = items
                return []
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
            }.asDriver(onErrorJustReturn: objects)
        
        let items = Driver.of(refresh, more).merge()
        
        // 空数据绑定
        items.map { $0.isEmpty }.asObservable().bind(to: isEmptyData).disposed(by: disposeBag)
        
        return Output(items: items)
    }
}
