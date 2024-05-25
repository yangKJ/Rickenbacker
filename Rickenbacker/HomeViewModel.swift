//
//  HomeViewModel.swift
//  Rickenbacker_Example
//
//  Created by Condy on 2021/10/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import Rickenbacker

enum ViewControllerType: String {
    case HBDNavigationBar = "Navigation"
    case CTMediator = "Mediator"
    case MJRefresh = "Refresh"
    case DZNEmptyDataSet = "EmptyData"
    case DZNEmptyDataWithoutBasic = "EmptyDataWithoutBasic"
    case CScroll = "VMScrollViewController"
    
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
        case .DZNEmptyDataWithoutBasic:
            return DZNEmptyDataSetWithoutBasicViewController()
        case .CScroll:
            let vm = CScrollViewModel.init()
            let view = CScrollView.init(viewModel: vm)
            return CScrollViewController(scrollView: view, viewModel: vm)
        }
    }
}

class HomeViewModel: ViewModel {
    /// 可观察数据源
    let datas = Observable<Array<ViewControllerType>>.of([
        .HBDNavigationBar,
        .CTMediator,
        .MJRefresh,
        .DZNEmptyDataSet,
        .DZNEmptyDataWithoutBasic,
        .CScroll,
    ])
}

extension UIColor {
    //返回随机颜色
    static var randomColor:UIColor{
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}
