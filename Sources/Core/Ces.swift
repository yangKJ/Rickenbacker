//
//  C.swift
//  FeatBox
//
//  Created by Condy on 2020/10/22.
//

import Foundation
import UIKit

/// 常用常量And方法
public struct Ces {
    
    public static let width  = UIScreen.main.bounds.width
    public static let height = UIScreen.main.bounds.height
    public static let navigationHeight = statusBarHeight + 44.0
    
    public static let statusBarHeight: CGFloat = {
        if #available(iOS 13.0, *) {
            let statusManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager
            return statusManager?.statusBarFrame.height ?? 20.0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }()
}
