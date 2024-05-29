//
//  ViewModel.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//

import Foundation

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    /// 输入转化输出，子类去写真正的业务逻辑代码
    /// Input conversion output, sub-category to write the real business logic code
    func transform(input: Input) -> Output
}

open class ViewModel: NSObject {
    
    required public override init() { }
}
