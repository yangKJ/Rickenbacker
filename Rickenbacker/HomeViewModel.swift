//
//  HomeViewModel.swift
//  Rickenbacker_Example
//
//  Created by Condy on 2021/10/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift

enum ViewControllerType: String {
    case HBDNavigationBar = "Navigation"
    case CTMediator = "Mediator"
    case MJRefresh = "Refresh"
    case DZNEmptyDataSet = "EmptyData"
    
    var viewController: UIViewController {
        switch self {
        case .HBDNavigationBar:
            return HBDNavigationBarViewController()
        case .CTMediator:
            return CTMediatorViewController()
        case .MJRefresh:
            return MJRefreshViewController()
        case .DZNEmptyDataSet:
            return DZNEmptyDataSetViewController()
        }
    }
}

class HomeViewModel: NSObject {
    /// 可观察数据源
    let datasObservable = Observable<Array<ViewControllerType>>.of([
        .HBDNavigationBar,
        .CTMediator,
        .MJRefresh,
        .DZNEmptyDataSet,
    ])
}
