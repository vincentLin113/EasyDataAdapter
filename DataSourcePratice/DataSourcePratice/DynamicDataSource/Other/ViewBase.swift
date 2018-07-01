//
//  ViewBase.swift
//  DataSourcePratice
//
//  Created by Vincent Lin on 2018/7/1.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import Foundation
import UIKit


public protocol ViewBase {
    var availableRect: CGRect { get set }
    var alertFactory: BasicAlertConvertible? { get set }
    var viewAssistant: ViewAssistantConvertible? { get set }
}
