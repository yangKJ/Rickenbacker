//
//  UITextField+Rx.swift
//  Rickenbacker
//
//  Created by Condy on 2023/5/12.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UITextField {
    
    public var textPath: Observable<String?> {
        return Observable.of(
            self.observe(String.self, "text"),
            self.text.asObservable()
        ).merge()
    }
}
