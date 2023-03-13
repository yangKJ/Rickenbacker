//
//  DriverOnErrorJustComplete.swift
//  Rickenbacker
//
//  Created by Condy on 2022/1/2.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
    
    public func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
}

extension ObservableConvertibleType {
    
    public func catchErrorJustReturn(closure: @escaping @autoclosure () throws -> Element) -> Observable<Element> {
        return asObservable().catch({ _ in
            return Observable.just(try closure())
        })
    }
    
    public func catchErrorJustComplete() -> Observable<Element> {
        return asObservable().catch({ _ in
            Observable.empty()
        })
    }
}

extension ObservableConvertibleType {
    
    public func asDriver(onErrorJustReturnClosure: @escaping @autoclosure () -> Element) -> Driver<Element> {
        return asDriver { _ in
            Driver.just(onErrorJustReturnClosure())
        }
    }
    
    public func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            Driver.empty()
        }
    }
}
