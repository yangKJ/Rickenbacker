//
//  UINavigationController+Ext.swift
//  Rickenbacker
//
//  Created by Condy on 2023/3/13.
//

import Foundation

extension UINavigationController {
    
    /// Get the specified controller in the stack.
    public func stackAppointedViewController<T>(_ type: T.Type) -> T? where T: UIViewController {
        let res = viewControllers.filter { $0 is T }
        guard let vc = res.first as? T else {
            return nil
        }
        return vc
    }
    
    /// Push to view controller and replace the last `replaceCount` view controller.
    /// - Parameters:
    ///   - controller: Push to view controller.
    ///   - replaceCount: The number of replacements, `Int.max` replace all.
    ///   - animated: Whether to turn on the animation.
    public func pushViewControllerAndReplace(_ controller: UIViewController, replaceCount: Int, animated: Bool) {
        if replaceCount == Int.max {
            setViewControllers([controller], animated: animated)
        } else {
            var cons = viewControllers
            let count = min(cons.count, replaceCount)
            cons.removeLast(count)
            cons.append(controller)
            setViewControllers(cons, animated: animated)
        }
    }
    
    /// Push to view controller and remove the `removeType` controller.
    /// - Parameters:
    ///   - controller: Push to view controller.
    ///   - removeType: Controllers to be removed.
    ///   - animated: Whether to turn on the animation.
    public func pushViewController(_ controller: UIViewController, removeType: UIViewController.Type, animated: Bool) {
        var cons = viewControllers
        var i = 0
        while i < cons.count {
            if cons.indices.contains(i), type(of: cons[i]) == removeType {
                cons.remove(at: i)
                i -= 1
            }
            i += 1
        }
        cons.append(controller)
        setViewControllers(cons, animated: animated)
    }
    
    /// Push to view controller and remove some the `removeTypes` controller.
    /// - Parameters:
    ///   - controller: Push to view controller.
    ///   - removeTypes: Controllers to be removed.
    ///   - animated: Whether to turn on the animation.
    public func pushViewController(_ controller: UIViewController, removeTypes: [UIViewController.Type], animated: Bool) {
        var cons = viewControllers
        var i = 0
        while i < cons.count {
            if cons.indices.contains(i), removeTypes.contains { type(of: cons[i]) == $0 } {
                cons.remove(at: i)
                i -= 1
            }
            i += 1
        }
        cons.append(controller)
        setViewControllers(cons, animated: animated)
    }
}
