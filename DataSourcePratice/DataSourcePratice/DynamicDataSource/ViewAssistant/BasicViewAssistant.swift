//
//  BasicViewAssistant.swift
//  DataSourcePratice
//
//  Created by Vincent Lin on 2018/7/1.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import Foundation
import UIKit


public enum DataManagerType {
    case userDefault, coreData
}

open class BasicViewAssistant: ViewAssistantConvertible {
    public var dataManager: DataConvertible = BasicData()
    public var logger: Logger? = Logger()
    
    public init(managerType: DataManagerType = .userDefault) {
        switch managerType {
        case .userDefault:
            self.dataManager = BasicData()
        default:
            return
        }
    }
}
