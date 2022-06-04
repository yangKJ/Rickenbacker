//
//  Optional.swift
//  Rickenbacker
//
//  Created by Condy on 2022/5/20.
//

import Foundation

public extension Optional {
    
    /// 可选值为空的时候返回 true
    var isNone: Bool {
        switch self {
        case .none:
            return true
        case .some:
            return false
        }
    }
    
    /// 可选值非空返回 true
    var isSome: Bool {
        return !isNone
    }
    
    /// 过滤可选项为nil的情况
    ///
    /// - Parameter valueOnNil: 可选项为空时的默认值
    /// - Returns: 解包后的值
    func filterNil(_ valueOnNil: Wrapped) -> Wrapped {
        switch self {
        case .some(let value):
            return value
        case .none:
            return valueOnNil
        }
    }
}
