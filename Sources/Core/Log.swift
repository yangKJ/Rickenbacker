//
//  Debug.swift
//  Rickenbacker
//
//  Created by Condy on 2021/12/30.
//

import Foundation

public struct Log {
    
    public static func debug(_ message: Any?...,
                             file: String = #file,
                             function: String = #function,
                             line: Int = #line) {
        #if DEBUG
        let params = message.compactMap{ "\($0.log_empty)" }.joined(separator: ", ")
        NSLog("""
              \n------- 🎈 Rickenbacker Log 🎈 -------
              File: \((file as NSString).lastPathComponent)
              Method: \(function)
              Line: \(line)
              Log: \(params)\n
              """)
        #endif
    }
    
    /// Split prefix `.`
    private static func split(_ string: String) -> String {
        return String(string.split(separator: ".").last ?? "")
    }
}

extension Optional {
    fileprivate var log_empty: Any {
        switch self {
        case .some(let value):
            return value
        case .none:
            return "nil"
        }
    }
}
