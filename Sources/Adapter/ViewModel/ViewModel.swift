//
//  ViewModel.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//

import Foundation
import RxSwift
import RxCocoa

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    /// 输入转化输出，子类去写真正的业务逻辑代码
    /// Input conversion output, sub-category to write the real business logic code
    func transform(input: Input) -> Output
}

public protocol ViewModelPrefix {
    /// inputs修饰前缀
    /// inputs modifier prefix
    var inputs: Self { get }
    /// outputs修饰前缀
    /// outputs modifier prefix
    var outputs: Self { get }
}

open class ViewModel: NSObject {
    
    public let disposeBag = DisposeBag()
    
    required public override init() { }
    
    deinit {
        D.DLog("🥁<\(D.split(String(describing: self))): ViewModel Deinited")
    }
}

extension ViewModel: ViewModelPrefix {
    public var inputs: Self {
        return self
    }
    
    public var outputs: Self {
        return self
    }
}
