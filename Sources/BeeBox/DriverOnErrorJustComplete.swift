//
//  DriverOnErrorJustComplete.swift
//  Rickenbacker
//
//  Created by Condy on 2022/1/2.
//

import Foundation
import RxSwift
import RxCocoa

public extension ObservableType {
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
}

public extension ObservableConvertibleType {
    
    func catchErrorJustReturn(closure: @escaping @autoclosure () throws -> Element) -> Observable<Element> {
        return asObservable().catch({ _ in
            return Observable.just(try closure())
        })
    }
    
    func catchErrorJustComplete() -> Observable<Element> {
        return asObservable().catch({ _ in
            Observable.empty()
        })
    }
}

public extension ObservableConvertibleType {
    
    func asDriver(onErrorJustReturnClosure: @escaping @autoclosure () -> Element) -> Driver<Element> {
        return asDriver { _ in
            Driver.just(onErrorJustReturnClosure())
        }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            Driver.empty()
        }
    }
}
