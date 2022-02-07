//
//  Debug.swift
//  Rickenbacker
//
//  Created by Condy on 2021/12/30.
//

import Foundation

public struct D {
    
    /// Debug模式日志打印
    /// - Parameters:
    ///   - message: 内容
    ///   - file: 文件名
    ///   - function: 方法名
    ///   - line: 行号
    public static func DLog(_ message: Any?...,
                            file: String = #file,
                            function: String = #function,
                            line: Int = #line) {
        #if DEBUG
        let params = message.compactMap{ "\($0.orEmpty)" }.joined(separator: ", ")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSSZ"
        formatter.locale = Locale(identifier: "zh_CN")
        let date = formatter.string(from: Date())
        print("""
              ------- 🎈 给我点赞 🎈 -------
              编译时间: \(date)
              文件名: \((file as NSString).lastPathComponent)
              方法名: \(function)
              行号: \(line)
              打印信息: \(params)\n
              """)
        #endif
    }
    
    /// 分割前缀`.`
    public static func split(_ string: String) -> String {
        return String(string.split(separator: ".").last ?? "")
    }
}

extension Optional {
    var orEmpty: Any {
        switch self {
        case .some(let value):
            return value
        case .none:
            return "nil"
        }
    }
}
