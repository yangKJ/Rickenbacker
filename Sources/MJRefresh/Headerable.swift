//
//  Headerable.swift
//  Rickenbacker
//
//  Created by Condy on 2022/5/20.
//

import Foundation
import MJRefresh

public typealias ViewModelHeaderAndFooterable = ViewModelHeaderable & ViewModelFooterable

public protocol ViewModelHeaderable: ViewModelRefreshable {
    /// 下拉刷新
    var header: MJRefreshHeader { get }
    
    /// 是否进入就刷新
    var enterBeginRefresh: Bool { get }
}

extension ViewModelHeaderable {
    
    public var header: MJRefreshHeader {
        return MJRefreshNormalHeader()
    }
    
    public var enterBeginRefresh: Bool {
        return true
    }
}
