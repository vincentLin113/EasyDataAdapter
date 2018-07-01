//
//  TableViewBase.swift
//  DataSourcePratice
//
//  Created by Vincent Lin on 2018/7/1.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import Foundation
import UIKit

public protocol TableViewBase {
    var adapter: SectionDemoAdapter? { get set }
    var tableView: UITableView { get set }
}

public typealias TableViewBaseConvertible = ViewBase & TableViewBase

public class BasicTableViewBase: UIViewController, TableViewBaseConvertible {
    public var availableRect: CGRect = UIScreen.main.bounds {
        didSet {
            updateFrame()
        }
    }
    
    public var alertFactory: BasicAlertConvertible?
    
    public var viewAssistant: ViewAssistantConvertible?
    
    public var adapter: SectionDemoAdapter?
    public var tableView: UITableView = {
        let _tableView = UITableView()
        _tableView.tableFooterView = UIView()
        return _tableView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        updateFrame()
        view.addSubview(tableView)
        self.adapter = SectionDemoAdapter.init(tableView: tableView)
    }
    
    fileprivate func updateFrame() {
        tableView.frame = availableRect
        view.layoutSubviews()
    }
}
