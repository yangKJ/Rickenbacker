//
//  Mediator.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//

import Foundation

public struct Mediator {
    
    public static let shared = Mediator()
    
    private init() { }
    
    public static func perform<T>(target: T.Type,
                                  action: String,
                                  module: String? = nil,
                                  params: [String: Any]? = nil) -> UIViewController? where T: NSObject {
        let clazz = String(describing: T.self)
        return performTarget(clazz, action: action, module: module, params: params) as? UIViewController
    }
    
    /// Designated local call making method
    public static func performTarget(_ class: String, action: String, module: String? = nil, params: [String: Any]? = nil) -> Any? {
        /// 防止粗心大意`action`带参数时刻未加`:`导致查找不到方法
        if let _ = params, !action.contains(":") {
            let action = action + ":"
            return __objc_performSelector(action, `class`, module, params)
        }
        return __objc_performSelector(action, `class`, module, params)
    }
}


// MARK: - 废弃原先的CTMediator，用法跟之前保持一致！
///
/// 参考用例
/// https://github.com/yangKJ/Rickenbacker/blob/master/Rickenbacker/Modules/Mediator/Mediator/SecondTarget.swift

/*

/// Used
if let vc = Mediator.Second_viewController(title: "biaoti") {
    pushButton.rx.tap
        .bind(to: rx.pushViewController(vc, animated: true))
        .disposed(by: disposeBag)
}

/// Componentized intermediate layer:
 
extension Mediator {
    static func Second_viewController(title: String) -> UIViewController? {
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

*/
