//
//  AlertConvertible.swift
//  DataSourcePratice
//
//  Created by Vincent Lin on 2018/7/1.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import Foundation
import UIKit

public enum AlertType {
    case alert, sheets
}

public enum AlertActionType {
    case action, cancel, retry
}

public typealias AlertActionCompletion = (_ action: AlertActionType) -> ()

public protocol BasicAlertConvertible {
    func show(title: String, msg: String, type: AlertType, action: AlertActionType, completion: AlertActionCompletion?)
}

public protocol ViewAssistantConvertible {
    var dataManager: DataConvertible { get set }
    var logger: Logger? { get }
}
public extension UIAlertController {
    convenience init(_ alerTitle: String = "",
                     subTitle msg: String? = "",
                     actionButtonTitle actionTitle: String? = "",
                     cancelButtonTitle cancelTitle: String? = "",
                     completion: AlertActionCompletion?) {
        self.init(title: alerTitle, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle ?? "Sure", style: .destructive) { (_) in
            completion?(.action)
        }
        let cancel = UIAlertAction(title: cancelTitle ?? "Cancel", style: .cancel) { (_) in
            completion?(.cancel)
        }
        addAction(action)
        addAction(cancel)
    }
}

public struct EasyAlert: BasicAlertConvertible {
    public func show(title: String, msg: String, type: AlertType, action: AlertActionType, completion: AlertActionCompletion?) {
        let alert = UIAlertController.init(
            "DemoTitle",
            subTitle: "DemoSubtitle",
            actionButtonTitle: "DemoAction",
            cancelButtonTitle: "DemoCancel",
            completion: completion)
    }
    
    
}
