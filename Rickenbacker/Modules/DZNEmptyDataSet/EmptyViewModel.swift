//
//  EmptyViewModel.swift
//  Rickenbacker_Example
//
//  Created by Condy on 2021/10/4.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Rickenbacker

class EmptyViewModel: ViewModel, ViewModelEmptiable, ViewModelHeaderable {
    
    let datas: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    func loadData() {
        
        let driver = NetworkService().randomResult().asObservable()
        
        driver.bind(to: datas).disposed(by: disposeBag)
        
        driver.map { $0.isEmpty }.bind(to: isEmptyData).disposed(by: disposeBag)
        
        driver.subscribe(onCompleted: { [weak self] in
            self?.refreshSubject.onNext(.endHeaderRefresh)
        }).disposed(by: disposeBag)
    }
}

// MARK: - 模拟网络请求
fileprivate struct NetworkService {
    static var index: Int = 0
    func randomResult() -> Driver<[String]> {
        NetworkService.index += 1
        if NetworkService.index % 2 == 1 {
            return Observable.just([])
                .delay(.seconds(2), scheduler: MainScheduler.instance)
                .asDriver(onErrorDriveWith: Driver.empty())
        }
        let items = (0 ... 19).map { _ in
            "Random data \(Int(arc4random() % 700))"
        }
        let observable = Observable.just(items)
        return observable
            .delay(.seconds(1), scheduler: MainScheduler.instance)
            .asDriver(onErrorDriveWith: Driver.empty())
    }
}
