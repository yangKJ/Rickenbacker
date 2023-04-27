//
//  C.swift
//  FeatBox
//
//  Created by Condy on 2020/10/22.
//

import Foundation
import UIKit

/// 常用常量And方法
public struct C {
    
    public static let width  = UIScreen.main.bounds.width
    public static let height = UIScreen.main.bounds.height
    public static let navigationHeight = statusBarHeight + 44.0
    public static let tabBarHeight = barHeight == 44 ? 83 : 49
    public static let barHeight: CGFloat = {
        if #available(iOS 13.0, *) {
            return C.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }()
    
    public static let statusBarHeight: CGFloat = {
        if #available(iOS 13.0, *) {
            let statusManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager
            return statusManager?.statusBarFrame.height ?? 20.0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }()
    
    /// 安全区域
    public static let topSafeAreaHeight = barHeight - 20
    public static let bottomSafeAreaHeight = tabBarHeight - 49
    public static let safeAreaEdgeInsets: UIEdgeInsets = {
        if #available(iOS 11.0, *) {
            return C.keyWindow?.safeAreaInsets ?? UIEdgeInsets.zero
        } else {
            return UIEdgeInsets.zero
        }
    }()
    
    public static let isIphoneX: Bool = {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return false
        }
        let size = UIScreen.main.bounds.size
        let notchValue: Int = Int(size.width / size.height * 100)
        if 216 == notchValue || 46 == notchValue {
            return true
        }
        guard #available(iOS 11.0, *) else { return false }
        if let bottomHeight = C.keyWindow?.safeAreaInsets.bottom {
            return bottomHeight > 30
        }
        return false
    }()
    
    public static let keyWindow: UIWindow? = {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .first(where: { $0 is UIWindowScene })
                .flatMap({ $0 as? UIWindowScene })?.windows
                .first(where: \.isKeyWindow)
        } else {
            return UIApplication.shared.keyWindow
        }
    }()
    
    public static let topViewController: UIViewController? = {
        var vc = C.keyWindow?.rootViewController
        if let presentedController = vc as? UITabBarController {
            vc = presentedController.selectedViewController
        }
        while let presentedController = vc?.presentedViewController {
            if let presentedController = presentedController as? UITabBarController {
                vc = presentedController.selectedViewController
            } else {
                vc = presentedController
            }
        }
        return vc
    }()
}

extension C {
    public static func className(_ obj: Any) -> String {
        let type = Mirror.init(reflecting: obj)
        let keys = NSStringFromClass(type.subjectType as! AnyClass)
        let key = keys.components(separatedBy: ".").last!
        return key
    }
    
    public static func instance(_ clazz: AnyClass?) -> UIViewController? {
        guard let clazz = clazz as? NSObject.Type else {
            return nil
        }
        return clazz.init() as? UIViewController
    }
}
