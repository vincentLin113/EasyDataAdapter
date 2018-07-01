//
//  Adapter.swift
//  DataSourcePratice
//
//  Created by Vincent Lin on 2018/7/1.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import Foundation
import UIKit



/// TableView elect event.
public typealias TableViewSelectionCompletion<DataType> = (IndexPath, DataType?, UITableViewCell?) -> Void
/// Set tableview cell height.
public typealias TableViewCellHeigthCompletion = (IndexPath) -> CGFloat
/// Called when cell did updated.
public typealias TableViewDataDidUpdate = () -> Void

public protocol TableViewEvent {
    var selectedCompletion: TableViewSelectionCompletion<DemoRowObject>? { get set }
    var cellHeight: TableViewCellHeigthCompletion? { get set }
    var dataDidUpdate: TableViewDataDidUpdate? { get set }
}

public typealias AdapterConvertible = UITableViewDelegate & UITableViewDataSource & AdapterDataConvertible & TableViewEvent

open class SectionDemoAdapter:NSObject, AdapterConvertible {
    public typealias DataType = EasyTableSection<DemoRowObject>
    
    public var selectedCompletion: TableViewSelectionCompletion<DemoRowObject>?
    public var cellHeight: TableViewCellHeigthCompletion?
    public var dataDidUpdate: TableViewDataDidUpdate?
    
    fileprivate var tableView: UITableView?
    
    public var data: [DataType] {
        return _data
    }
    private var _data: [DataType] = []
    
    public init(tableView: UITableView) {
        super.init()
        self.tableView = tableView
        self._data = self.configureData()
        self.tableView?.register(DemoTableCell.self, forCellReuseIdentifier: DemoTableCell.reuseIdentifier)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
    }
    
    private func configureData() -> [DataType] {
        let row1 = DemoRowObject(title: "Row1", backgroundColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), titleTextColor: #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1))
        let row2 = DemoRowObject(title: "Row2", backgroundColor: #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1), titleTextColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))
        let row3 = DemoRowObject(title: "Row3", backgroundColor: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), titleTextColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1))
        let section: DataType = EasyTableSection<DemoRowObject>.init(rows: [row1, row2, row3])
        return [section]
    }
    
    public func updateData(_ data: [DataType]) {
        self._data = data
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].numberOfRows
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DemoTableCell.reuseIdentifier, for: indexPath) as? DemoTableCell else {
            return UITableViewCell()
        }
        if data.count > indexPath.section, data[indexPath.section].rows.count > indexPath.row {
            let item = data[indexPath.section].rows[indexPath.item]
            cell.title = "\(item.title)"
            cell.backgroundColor = item.backgroundColor
            cell.titleLabel.textColor = item.titleTextColor
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        self.selectedCompletion?(indexPath, self.data[indexPath.section].rows[indexPath.row], cell)
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight?(indexPath) ?? 40.0
    }
}
