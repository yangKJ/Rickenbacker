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
    public static func text(_ string: String, forResource: String = "Rickenbacker", comment: String = "Localizable") -> String {
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
    
    /// Read json data
    public static func jsonData(_ named: String, forResource: String = "Rickenbacker") -> Data? {
        let bundle: Bundle?
        if let bundlePath = Bundle.main.path(forResource: forResource, ofType: "bundle") {
            bundle = Bundle.init(path: bundlePath)
        } else {
            bundle = Bundle.main
        }
        guard let path = ["json", "JSON", "Json"].compactMap({
            bundle?.path(forResource: named, ofType: $0)
        }).first else {
            return nil
        }
        let contentURL = URL(fileURLWithPath: path)
        return try? Data(contentsOf: contentURL)
    }
}
