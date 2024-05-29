//
//  Res.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//

import Foundation

/// 资源文件读取
public struct Res {
    
    /// Load image resources
    public static func image(_ named: String, forResource: String = "Rickenbacker") -> UIImage {
        if let image = UIImage.init(named: named) {
            return image
        }
        let bundle = readFrameworkBundle(with: forResource)
        if let image = UIImage(named: named, in: bundle, compatibleWith: nil) {
            return image
        }
        return UIImage()
    }
    
    /// Read multilingual text resources
    public static func text(_ key: String, forResource: String = "Rickenbacker", comment: String = "Localizable") -> String {
        guard let bundle = readFrameworkBundle(with: forResource) else {
            return key
        }
        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: comment)
    }
    
    /// Read color resource
    @available(iOS 11.0, *)
    public static func color(_ named: String, forResource: String = "Rickenbacker") -> UIColor? {
        if let color = UIColor.init(named: named) {
            return color
        }
        guard let bundle = readFrameworkBundle(with: forResource) else {
            return nil
        }
        return UIColor(named: named, in: bundle, compatibleWith: nil)
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
    
    public static func readFrameworkBundle(with bundleName: String) -> Bundle? {
        let candidates = [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,
            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: Res__.self).resourceURL,
            // For command-line tools.
            Bundle.main.bundleURL,
        ]
        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        return Bundle(for: Res__.self)
    }
}

fileprivate final class Res__ { }

extension Res {
    
    public static func readImage(_ named: String, ofType: String = "png") -> UIImage? {
        let containnerBundle = Bundle(for: Res__.self)
        let scale = min(Int(UIScreen.main.scale), 3)
        guard let resourcePath = containnerBundle.path(forResource: "Rickenbacker", ofType: "bundle"),
              let bundle = Bundle.init(path: resourcePath),
              let path = bundle.path(forResource: named + "@\(scale)x", ofType: ofType) else {
            return nil
        }
        return UIImage.init(contentsOfFile: path)
    }
    
    public static var base_black_back: UIImage? {
        readImage("base_black_back")?.withRenderingMode(.alwaysTemplate)
    }
    
    public static var base_black_close: UIImage? {
        readImage("base_black_close")?.withRenderingMode(.alwaysTemplate)
    }
    
    public static var base_line_navigation: UIImage? {
        readImage("base_line_navigation")
    }
}
