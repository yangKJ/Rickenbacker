//
//  Compatible.swift
//  FeatBox
//
//  Created by Condy on 2022/1/2.
//

import Foundation
import UIKit

/// 添加 `cdy` 前缀命名空间
public struct RINamespace<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol RICompatible { }

extension RICompatible {
    public var cdy: RINamespace<Self> {
        get { return RINamespace(self) }
        set { }
    }
    public static var cdy: RINamespace<Self>.Type {
        RINamespace<Self>.self
    }
}

extension NSObject: RICompatible { }
extension UIColor: RICompatible { }
extension String: RICompatible { }
extension Array: RICompatible { }
extension Dictionary: RICompatible { }
extension Bool: RICompatible { }
extension CALayer: RICompatible { }
extension DispatchQueue: RICompatible { }
extension UIButton: RICompatible { }
extension UIImage: RICompatible { }
extension UIViewController: RICompatible { }
extension UITableView: RICompatible { }
extension CGFloat: RICompatible { }
