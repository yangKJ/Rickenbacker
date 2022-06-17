//
//  ViewModelPrefix.swift
//  Rickenbacker
//
//  Created by Condy on 2022/6/17.
//

import Foundation

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
