//
//  ResourceManager.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//

import class UIKit.UIColor
import class UIKit.UIImage
import Foundation

/// 资源文件读取
@objc public class R: NSObject {
    
    /// Load image resources
    @objc public static func image(_ named: String, forResource: String = "Rickenbacker") -> UIImage {
        let bundlePath = Bundle.main.path(forResource: forResource, ofType: "bundle")
        let bundle = Bundle.init(path: bundlePath!)
        guard let image = UIImage(named: named, in: bundle, compatibleWith: nil) else {
            let image = UIImage(named: named)
            return image ?? UIImage()
        }
        return image
    }
    
    /// Read multilingual text resources
    @objc public static func text(_ string: String,
                                  forResource: String = "Rickenbacker",
                                  comment: String = "Localizable") -> String {
        let bundlePath = Bundle.main.path(forResource: forResource, ofType: "bundle")
        if let bundle = Bundle.init(path: bundlePath!) {
            return NSLocalizedString(string, tableName: nil, bundle: bundle, value: "", comment: comment)
        }
        return ""
    }
    
    /// Read color resource
    @available(iOS 11.0, *)
    public static func color(_ string: String, forResource: String = "Rickenbacker") -> UIColor {
        let bundlePath = Bundle.main.path(forResource: forResource, ofType: "bundle")
        let bundle = Bundle.init(path: bundlePath!)
        guard let color = UIColor(named: string, in: bundle, compatibleWith: nil) else {
            return UIColor.white
        }
        return color
    }
}
