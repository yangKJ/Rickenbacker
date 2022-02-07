//
//  ResourceManager.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//

import UIKit

/// 资源文件读取
@objc public class R: NSObject {
    
    /// 加载图片资源
    /// - Parameters:
    ///   - named: 图片名称
    ///   - forResource: 资源包名
    /// - Returns: 图片
    @objc public static func image(_ named: String, forResource: String? = "Rickenbacker") -> UIImage {
        let bundlePath = Bundle.main.path(forResource: forResource, ofType: "bundle")
        let bundle = Bundle.init(path: bundlePath!)
        guard let image = UIImage(named: named, in: bundle, compatibleWith: nil) else {
            let image = UIImage(named: named)
            return image ?? UIImage()
        }
        return image
    }
    
    /// 读取文字资源
    /// - Parameters:
    ///   - string: 文本
    ///   - forResource: 资源包名
    ///   - comment: 多语言文件名
    /// - Returns: 对应语言文本
    @objc public static func text(_ string: String,
                                  forResource: String? = "Rickenbacker",
                                  comment: String? = "Localizable") -> String {
        let bundlePath = Bundle.main.path(forResource: forResource, ofType: "bundle")
        if let bundle = Bundle.init(path: bundlePath!) {
            return NSLocalizedString(string, tableName: nil, bundle: bundle, value: "", comment: comment!)
        }
        return ""
    }
}
