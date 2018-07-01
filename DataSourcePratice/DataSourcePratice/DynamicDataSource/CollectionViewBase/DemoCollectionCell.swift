//
//  DemoCollectionCell.swift
//  DataSourcePratice
//
//  Created by Vincent Lin on 2018/7/1.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import Foundation
import UIKit

open class SampleCollectionCell: UICollectionViewCell, ReusableCell {
    
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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    fileprivate func configure() {
        addSubview(titleLabel)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = self.bounds
        titleLabel.isHidden = false
    }
}
