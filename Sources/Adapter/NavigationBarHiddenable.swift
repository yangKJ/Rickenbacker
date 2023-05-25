//
//  NavigationBarHiddenable.swift
//  Rickenbacker
//
//  Created by Condy on 2022/5/20.
//

import Foundation
import ObjectiveC

/// 隐藏 navigation bar
public protocol NavigationBarHiddenable { }

fileprivate var PreviousNavigationHiddenContext: UInt8 = 0

extension BasicsViewController {
    
    private var previousNavigationHidden: Bool? {
        get {
            if let hidden = objc_getAssociatedObject(self, &PreviousNavigationHiddenContext) {
                return hidden as? Bool
            } else {
                let hidden = false
                objc_setAssociatedObject(self, &PreviousNavigationHiddenContext, hidden, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return hidden
            }
        }
        set {
            objc_setAssociatedObject(self, &PreviousNavigationHiddenContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension BasicsViewController {
    
    final func setupNavigationBarHiddenableViewWillAppear(_ animated: Bool) {
        if self is NavigationBarHiddenable {
            if previousNavigationHidden == nil {
                if let viewControllers = self.navigationController?.viewControllers,
                   (viewControllers.count < 2 || viewControllers[viewControllers.count-2] is NavigationBarHiddenable) {
                    self.previousNavigationHidden = true
                } else {
                    self.previousNavigationHidden = self.navigationController?.isNavigationBarHidden
                }
            }
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            return
        } else if self.navigationController?.isNavigationBarHidden ?? false {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    final func setupNavigationBarHiddenableViewWillDisappear(_ animated: Bool) {
        if self is NavigationBarHiddenable,
           let controllers = self.navigationController?.viewControllers,
           controllers.contains(self) == false {
            self.navigationController?.setNavigationBarHidden(self.previousNavigationHidden ?? false, animated: true)
        }
    }
    
    final func setupNavigationBarHiddenableViewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            guard let top = self.navigationController?.topViewController, top == self else {
                return
            }
            if !(self is NavigationBarHiddenable) && (self.navigationController?.isNavigationBarHidden ?? false) {
                self.navigationController?.setNavigationBarHidden(false, animated: false)
            }
        }
    }
}
