//
//  DataConvertible.swift
//  DataSourcePratice
//
//  Created by Vincent Lin on 2018/7/1.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import Foundation
import UIKit

public protocol DataConvertible {
    func writeDataToLocal(_ data:Any?, forKey key: String) throws
    func readLocalData(byKey key: String) throws -> Any?
    func update(_ data:Any?, forKey key: String)
    func getData(byKey key: String) -> Any?
}

public class BasicData: DataConvertible {
    public func writeDataToLocal(_ data: Any?, forKey key: String) throws {
        
    }
    
    public func readLocalData(byKey key: String) throws -> Any? {
        return nil
    }
    
    public func update(_ data: Any?, forKey key: String) {
        
    }
    
    public func getData(byKey key: String) -> Any? {
        return nil
    }
}
