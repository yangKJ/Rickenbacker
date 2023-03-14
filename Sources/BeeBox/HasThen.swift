//
//  HasThen.swift
//  Rickenbacker
//
//  Created by Condy on 2023/3/13.
//

import RxSwift
import RxCocoa

extension ObservableType {
    /// Example:
    ///
    ///        var objects: [String] = []
    ///        var page: Int = 1
    ///
    ///        // 下拉刷新
    ///        let refresh = input.headerRefresh.then(page = 1)
    ///            .flatMapLatest {
    ///                RefreshAPI.refresh(page).request()
    ///            }.map { (items) -> [String] in
    ///                objects = items
    ///                return objects
    ///            }.asDriver(onErrorJustReturn: [])
    ///
    ///        // 上拉加载更多
    ///        let more = input.footerRefresh.then(page += 1)
    ///            .flatMapLatest {
    ///                RefreshAPI.refresh(page).request()
    ///            }.map { (items) -> [String] in
    ///                objects += items
    ///                return objects
    ///            }.asDriver(onErrorJustReturn: [])
    ///
    ///        let items = Driver.of(refresh, more).merge()
    ///
    /// - Parameter closure: Closure operation.
    /// - Returns: Observable sequence.
    public func then(_ closure: @escaping @autoclosure () throws -> Void) -> Observable<Element> {
        return map {
            try closure()
            return $0
        }
    }
}

extension Driver {
    
    public func then(_ closure: @escaping @autoclosure () -> Void) -> SharedSequence<SharingStrategy, Element> {
        return map {
            closure()
            return $0
        }
    }
}
