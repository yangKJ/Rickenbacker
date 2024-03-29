//
//  ViewModel.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//

import Foundation
import RxSwift
import RxCocoa

public protocol ViewModelPrefix {
    /// inputs修饰前缀
    /// inputs modifier prefix
    var inputs: Self { get }
    /// outputs修饰前缀
    /// outputs modifier prefix
    var outputs: Self { get }
}

extension ViewModelPrefix {
    public var inputs: Self {
        return self
    }
    
    public var outputs: Self {
        return self
    }
}

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    /// 输入转化输出，子类去写真正的业务逻辑代码
    /// Input conversion output, sub-category to write the real business logic code
    func transform(input: Input) -> Output
}

open class ViewModel: NSObject, ViewModelPrefix, HasDisposeBag {
    
    required public override init() { }
    
    deinit {
        Log.debug("\(self.description): ViewModel Deinited", file: "\(type(of: self))")
    }
}
