//
//  HasThen.swift
//  RxSwiftX
//
//  Created by Pircate on 2018/6/5.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import RxSwift
import RxCocoa

public extension ObservableType {
    
    func then(_ closure: @escaping @autoclosure () throws -> Void) -> Observable<Element> {
        return map {
            try closure()
            return $0
        }
    }
}

public extension Driver {
    
    func then(_ closure: @escaping @autoclosure () -> Void) -> SharedSequence<SharingStrategy, Element> {
        return map {
            closure()
            return $0
        }
    }
}
