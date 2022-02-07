//
//  MJRefreshAPI.swift
//  Rickenbacker_Example
//
//  Created by 77。 on 2022/1/13.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

enum MJRefreshAPI {
    case refresh(Int)
    
    func request() -> Driver<[String]> {
        switch self {
        case .refresh(let page):
            return NetworkService.randomResult(page)
        }
    }
}

fileprivate struct NetworkService {
    
    static func randomResult(_ page: Int) -> Driver<[String]> {
        if page >= 5 {
            return Observable.just([])
                .delay(.seconds(1), scheduler: MainScheduler.instance)
                .asDriver(onErrorDriveWith: Driver.empty())
        }
        let items = (0 ... 19).map { _ in
            "current page = \(page), Random data \(Int(arc4random() % 700))"
        }
        let observable = Observable.just(items)
        return observable
            .delay(.seconds(1), scheduler: MainScheduler.instance)
            .asDriver(onErrorDriveWith: Driver.empty())
    }
}
