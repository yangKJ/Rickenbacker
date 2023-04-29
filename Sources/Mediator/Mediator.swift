//
//  Mediator.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//

import Foundation

public struct Mediator {
    
    public typealias MediatorParams = [String: Any]
    
    public static var shared = Mediator()
    
    /// 缓存获取到的控制器《只缓存不带入参数的控制器》
    lazy var cacheViewControllers: [String: UIViewController] = [:]
    
    private init() { }
    
    /// Designated local call making method
    public static func performTarget(_ class: String, action: String, module: String? = nil, params: MediatorParams? = nil) -> Any? {
        /// 防止粗心大意`action`带参数时刻未加`:`导致查找不到方法
        if let _ = params, !action.contains(":") {
            let action = action + ":"
            return __objc_performSelector(action, `class`, module, params)
        }
        return __objc_performSelector(action, `class`, module, params)
    }
}

extension Mediator {
    
    public static func mediatorViewController(_ clazz: String, action: String, module: String? = nil, params: MediatorParams? = nil) -> UIViewController? {
        performTarget(clazz, action: action, module: module, params: params) as? UIViewController
    }
    
    /// 简便获取控制器
    /// class: `prefix`Target,
    /// action: setup`prefix`ViewController
    /// - Parameters:
    ///   - prefix: 前缀名称
    ///   - module: 模块
    ///   - params: 参数
    /// - Returns: 控制器
    public static func viewController(prefix: String, module: String? = nil, params: MediatorParams? = nil) -> UIViewController? {
        let clazz = prefix + "Target"
        let action = "setup\(prefix)ViewController"
        return performTarget(clazz, action: action, module: module, params: params) as? UIViewController
    }
    
    /// 获取缓存控制器，带参数的不会缓存
    public static func getCacheViewController(_ clazz: String, action: String, module: String? = nil, params: MediatorParams? = nil) -> UIViewController? {
        if let _ = params {
            return mediatorViewController(clazz, action: action, module: module, params: params)
        }
        let key = (module ?? "") + "_" + clazz
        if let vc = Mediator.shared.cacheViewControllers[key] {
            return vc
        }
        if let vc = mediatorViewController(clazz, action: action, module: module) {
            Mediator.shared.cacheViewControllers[key] = vc
            return vc
        }
        return nil
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
