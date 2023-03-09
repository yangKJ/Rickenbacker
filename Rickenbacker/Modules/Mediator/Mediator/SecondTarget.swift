//
//  SecondTarget.swift
//  Rickenbacker_Example
//
//  Created by Condy on 2021/10/3.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Rickenbacker

extension Mediator {
    static func Second_viewController(title: String) -> UIViewController? {
//        self.performTarget(String(describing: SecondTarget.self),
//                           action: "setupSecondViewController",
//                           module: "Rickenbacker_Example",
//                           params: ["title": title]) as? UIViewController
        self.perform(target: SecondTarget.self,
                     action: "setupSecondViewController",
                     module: "Rickenbacker_Example",
                     params: ["title": title])
    }
}

class SecondTarget: NSObject {
    /// 备注提示，这里必须加上`@objc`
    /// 否则会出现找不到该方法从而导致控制器为`nil`问题
    @objc func setupSecondViewController(_ params: NSDictionary) -> UIViewController? {
        guard let title = params["title"] as? String else { return nil }
        let vm = SecondViewModel.init(title: title)
        let vc = SecondViewController.init(viewModel: vm)
        return vc
    }
}
