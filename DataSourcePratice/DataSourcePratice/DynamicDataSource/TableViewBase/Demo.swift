//
//  Demo.swift
//  DataSourcePratice
//
//  Created by Vincent Lin on 2018/7/1.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import Foundation
import UIKit

public class DemoTableController: BasicTableViewBase {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "DemoTable"
        self.adapter?.selectedCompletion = {
            indexPath, data, cell in
            print("indexPath: \(indexPath)")
        }
    }
}

