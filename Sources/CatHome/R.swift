//
//  ResourceManager.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//

import Foundation

/// 资源文件读取
public struct R {
    
    /// Load image resources
    public static func image(_ named: String, forResource: String = "Rickenbacker") -> UIImage {
        let imageblock = { (name: String) -> UIImage in
            return UIImage(named: named) ?? UIImage()
        }
        guard let bundlePath = Bundle.main.path(forResource: forResource, ofType: "bundle") else {
            return imageblock(named)
        }
        let bundle = Bundle.init(path: bundlePath)
        guard let image = UIImage(named: named, in: bundle, compatibleWith: nil) else {
            return imageblock(named)
        }
        return image
    }
    
    /// Read multilingual text resources
    public static func text(_ string: String,
                            forResource: String = "Rickenbacker",
                            comment: String = "Localizable") -> String {
        guard let bundlePath = Bundle.main.path(forResource: forResource, ofType: "bundle"),
              let bundle = Bundle.init(path: bundlePath) else {
            return string
        }
        return NSLocalizedString(string, tableName: nil, bundle: bundle, value: "", comment: comment)
    }
    
    /// Read color resource
    @available(iOS 11.0, *)
    public static func color(_ string: String, forResource: String = "Rickenbacker") -> UIColor? {
        guard let bundlePath = Bundle.main.path(forResource: forResource, ofType: "bundle"),
              let bundle = Bundle.init(path: bundlePath),
              let color = UIColor(named: string, in: bundle, compatibleWith: nil) else {
            return nil
        }
        return color
    }
}
