//
//  CollectionBase.swift
//  DataSourcePratice
//
//  Created by Vincent Lin on 2018/7/1.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import Foundation
import UIKit

/// The protocol you need to implement if you need to be CollectionViewBase
public protocol CollectionBase {
    var collectionView: UICollectionView { get set }
    var adapter: CollectionSectionAdapter? { get set }
}

//ViewBase
//var availableRect: CGRect { get set }
//var alertFactory: BasicAlertConvertible? { get set }
//var viewAssistant: ViewAssistantConvertible? { get set }
public typealias CollectionBaseConvertible = CollectionBase & ViewBase
open class BasicCollectionBase: UIViewController, CollectionBaseConvertible {
    public var availableRect: CGRect = UIScreen.main.bounds {
        didSet {
            updateFrame()
        }
    }
    public var alertFactory: BasicAlertConvertible? = nil
    
    public var viewAssistant: ViewAssistantConvertible? = nil
    
    public var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let _collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        _collectionView.alwaysBounceVertical = true
        _collectionView.isScrollEnabled = true
        _collectionView.backgroundColor = UIColor.white
        _collectionView.showsHorizontalScrollIndicator = false
        return _collectionView
    }()
    
    public var adapter: CollectionSectionAdapter?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        updateFrame()
        view.addSubview(collectionView)
        self.adapter = CollectionSectionAdapter(collectionView: collectionView)
    }
    
    fileprivate func updateFrame() {
        self.collectionView.frame = self.availableRect
    }
    
}


open class SampleCollectionController: BasicCollectionBase {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SampleCollectionController"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.adapter?.updateMinimumLineSpacingForSection({ [weak self] (section) -> CGFloat in
            guard let `self` = self else { return 0.0 }
            return section % 1 == 0 ? 50 : 100
        }).updateInsetForSection({ (insetSection) -> UIEdgeInsets in
            return UIEdgeInsets(top: 5.0, left: 15.0, bottom: 0.0, right: 15.0)
        }).updateCellSize({ (indexPath) -> (CGSize) in
            return indexPath.row % 2 == 0
                ? CGSize(width: self.view.frame.width / 2 - 50, height: 180)
                : CGSize(width: 150, height: 250)
        }).didSelectedCell({ (indexPath, item, cell) in
            print("selected: \(indexPath), item: \(item), cell:\(cell)")
        })
        
        self.alertFactory = EasyAlert();
        /**
         Adapter handle `delegate` and `dataSource`
         */
        ///self.adapter = ...
        /**
         ViewAssistant handle `print` and `localData`
         */
        ///self.viewAssistant = ...
    }
    
}
