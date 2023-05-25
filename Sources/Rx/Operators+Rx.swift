//
//  Operators+Rx.swift
//  Rickenbacker
//
//  Created by Condy on 2023/5/12.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - Precedence Groups
precedencegroup Binding {
    associativity: none
    higherThan: Additive
}

precedencegroup Additive {
    associativity: left
    higherThan: MultiplicationPrecedence
}

precedencegroup Right {
    associativity: right
    higherThan: Additive
}

// MARK: - Dispose bag
infix operator >>> : Additive

public func >>> (lhs: Disposable?, rhs: DisposeBag) {
    if let disposable = lhs {
        rhs.insert(disposable)
    }
}

// MARK: - Two-way binding
infix operator <-> : Binding

public func <-> <T>(property: ControlProperty<T>, variable: BehaviorRelay<T>) -> Disposable {
    let uiDisposable = variable.bind(to: property)
    let bindToVariable = property.subscribe(onNext: { n in
        variable.accept(n)
    }, onCompleted:  {
        uiDisposable.dispose()
    })
    
    return Disposables.create(uiDisposable, bindToVariable)
}

// MARK: - One-way binding
infix operator <-- : Right

public func <-- <T>(binder: Binder<T>, observable: Observable<T>) -> Disposable {
    let disposable = observable.bind(to: binder)
    return disposable
}

public func <-- <T>(binder: Binder<T>, variable: BehaviorRelay<T>) -> Disposable {
    return variable.bind(to: binder)
}

// MARK: - Convert to Optional
prefix operator ?=

public prefix func ?= <T>(variable: BehaviorRelay<T>) -> Observable<T?> {
    let optional = variable.map { value -> T? in
        return value
    }
    return optional
}

public prefix func ?= <T>(observable: Observable<T>) -> Observable<T?> {
    let optional = observable.map { value -> T? in
        return value
    }
    return optional
}
