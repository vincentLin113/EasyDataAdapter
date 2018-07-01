//
//  TableSection.swift
//  DataSourcePratice
//
//  Created by Vincent Lin on 2018/7/1.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import Foundation
import UIKit

public protocol TableSection {
    associatedtype RowType
    var rows: [RowType] { get set }
    var numberOfRows: Int { get }
}

public class EasyTableSection<RowType>: TableSection {
    public var rows: [RowType] = []
    public var numberOfRows: Int {
        return rows.count
    }
    
    init(rows: [RowType]) {
        self.rows = rows
    }
    
    subscript (index index: Int) -> RowType? {
        if index < rows.count {
            return self.rows[index]
        } else {
            return nil
        }
    }

}

public extension Array where Element: EasyTableSection<DemoRowObject> {
    subscript (checkIndexPath indexPath: IndexPath) -> DemoRowObject? {
        if self.count > indexPath.section, self[indexPath.section].rows.count > indexPath.row {
            return self[indexPath.section].rows[indexPath.row]
        } else {
            return nil
        }
    }
}

public class DemoRowObject: NSObject {
    var title: String = ""
    var backgroundColor: UIColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
    var titleTextColor: UIColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    
    public init(title: String, backgroundColor: UIColor, titleTextColor: UIColor) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.titleTextColor = titleTextColor
    }
}
