//
//  Logger.swift
//  DataSourcePratice
//
//  Created by Vincent Lin on 2018/7/1.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import Foundation

open class Logger: NSObject{
    static fileprivate var enable:Bool{
        get{
            #if DEBUG
            return true
            #else
            return false
            #endif
        }
    }
    
    static func log<T>(message: T,file: String = #file,method: String = #function,line: Int = #line)
    {
        if enable{
            print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
        }
    }
    
}
