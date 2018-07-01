//
//  TableCell.swift
//  DataSourcePratice
//
//  Created by Vincent Lin on 2018/7/1.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import Foundation
import UIKit

public class DemoTableCell: UITableViewCell, ReusableCell {
    
    var title: String? {
        didSet {
            guard let title = title else { return }
            self.titleLabel.text = ""
            self.titleLabel.text = title
        }
    }
    
    let titleLabel: UILabel = {
        let _titleLabel = UILabel()
        _titleLabel.textColor = .darkText
        _titleLabel.isHidden = true
        return _titleLabel
    }()
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = self.bounds
        titleLabel.isHidden = false
    }
}
