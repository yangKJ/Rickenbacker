//
//  Color.swift
//  KJCategories_Example
//
//  Created by Condy on 2022/1/25.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

extension UIColor {
    static let background = UIColor(named: "background")
    static let defaultTint = UIColor(named: "defaultTint")
    static let cell_background = UIColor(named: "cell_background")
}

var statusBarHeight: CGFloat {
    if #available(iOS 13.0, *) {
        let statusManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager
        return statusManager?.statusBarFrame.height ?? 20.0
    } else {
        return UIApplication.shared.statusBarFrame.height
    }
}

var navigationHeight: CGFloat {
    return 44 + statusBarHeight
}
