//
//  Footerable.swift
//  Rickenbacker
//
//  Created by Condy on 2022/5/20.
//

import Foundation
import MJRefresh

public protocol ViewModelFooterable: ViewModelRefreshable {
    /// 上拉加载更多
    var footer: MJRefreshFooter { get }
}

extension ViewModelFooterable {
    
    public var footer: MJRefreshFooter {
        return MJRefreshBackNormalFooter()
    }
}
