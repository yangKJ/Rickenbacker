//
//  SecondViewController+CTMediator.swift
//  Rickenbacker_Example
//
//  Created by Condy on 2021/10/3.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Rickenbacker

extension CTMediator {
    
    /// Swift调度者
    func Second_viewController(title: String) -> (UIViewController?) {
        let params = [
            "title": title,
            kCTMediatorParamsKeySwiftTargetModuleName: "Rickenbacker_Example"
        ] as [AnyHashable : Any]
        let viewController = self.performTarget(String(describing: SecondViewController.self),
                                                action: "Extension_ViewController",
                                                params: params,
                                                shouldCacheTarget: false) as? UIViewController
        return (viewController)
    }
}

class Target_SecondViewController: NSObject {
    /// 备注提示，这里必须加上`@objc`
    /// 否则会出现找不到该方法从而导致控制器为`nil`问题
    @objc func Action_Extension_ViewController(_ params: NSDictionary) -> UIViewController? {
        guard let title = params["title"] as? String else { return nil }
        let vm = SecondViewModel.init(title: title)
        let vc = SecondViewController.init(viewModel: vm)
        return vc
    }
}
