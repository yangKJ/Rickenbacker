//
//  CTMediator+Extension.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//

///`CTMediator`文档
/// https://github.com/casatwy/CTMediator
/// https://casatwy.com/CTMediator_in_Swift.html

/// 参考用例
/// https://github.com/yangKJ/Rickenbacker/blob/master/Rickenbacker/Modules/CTMediator/CTMediator/SecondViewController+CTMediator.swift

import Foundation

#if canImport(CTMediator)
import CTMediator

@objc public extension CTMediator {
    @objc static var shared: CTMediator {
        return CTMediator.sharedInstance()
    }
}

#endif
