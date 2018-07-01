//
//  AdapterData.swift
//  DataSourcePratice
//
//  Created by Vincent Lin on 2018/7/1.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import Foundation

public protocol AdapterDataConvertible {
    associatedtype DataType
    var data: [DataType] { get }
    func updateData(_ data: [DataType])
}
