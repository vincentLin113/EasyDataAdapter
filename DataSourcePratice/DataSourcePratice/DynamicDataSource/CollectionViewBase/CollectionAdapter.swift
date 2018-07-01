//
//  CollectionAdapter.swift
//  DataSourcePratice
//
//  Created by Vincent Lin on 2018/7/1.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import Foundation
import UIKit

public typealias CollectionSelectionCompletion = (IndexPath, DemoRowObject?, SampleCollectionCell?) -> Void
public typealias CollectionCellSize = (IndexPath) -> (CGSize)
public typealias CollectionMinimumLineSpacingForSection = (Int) -> CGFloat
public typealias CollectionMinimumInteritemSpacingForSection = (Int) -> CGFloat
public typealias CollectionInsetForSection = (Int) -> UIEdgeInsets

/// 基本事件代理封裝
public protocol CollectionAdapterEvent {
    var selectedItem: CollectionSelectionCompletion? { get }
    var cellSize: CollectionCellSize? { get }
    /// Implement `collectionViewLayout minimumLineSpacingForSectionAtIndex`
    var minimumLineSpacingForSection: CollectionMinimumLineSpacingForSection? { get }
    /// Implement `collectionViewLayout minimumInteritemSpacingForSectionAtIndex`
    var minimumInteritemSpacingForSection: CollectionMinimumInteritemSpacingForSection? { get }
    /// Implement `collectionViewLayout insetForSectionAtIndex`
    var insetForSection: CollectionInsetForSection? { get }
}

public typealias CollectionAdapterConvertible = UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout & AdapterDataConvertible & CollectionAdapterEvent

/// Called when cell did updated.
public typealias CollectionViewDataDidUpdate = () -> Void

open class CollectionSectionAdapter: NSObject, CollectionAdapterConvertible {
    public typealias DataType = EasyTableSection<DemoRowObject>
    /// For implement `delegate` and `dataSource`, unvisible forever.
    private var collectionView: UICollectionView?
    public var data: [DataType] {
        return _data
    }
    /// Because `data` is unsettable, so everything updated assign to me.
    private var _data: [DataType] = []
    public var selectedItem: CollectionSelectionCompletion?
    public var cellSize: CollectionCellSize?
    /// Implement `collectionViewLayout minimumLineSpacingForSectionAtIndex`
    public var minimumLineSpacingForSection: CollectionMinimumLineSpacingForSection?
    /// Implement `collectionViewLayout minimumInteritemSpacingForSectionAtIndex`
    public var minimumInteritemSpacingForSection: CollectionMinimumInteritemSpacingForSection?
    /// Implement `collectionViewLayout insetForSectionAtIndex`
    public var insetForSection: CollectionInsetForSection?
    public var didUpdateData: CollectionViewDataDidUpdate?
    /**
     - parameter collectionView:       放入接受代理的collectionView;
     */
    public init(collectionView: UICollectionView) {
        super.init()
        self.collectionView = collectionView
        self._data = configureData()
        self.collectionView?.register(SampleCollectionCell.self, forCellWithReuseIdentifier: SampleCollectionCell.reuseIdentifier)
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
    }
    
    public func updateData(_ data: [DataType]) {
        self._data = data
        self.didUpdateData?()
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    fileprivate func configureData() -> [DataType] {
        /// 先建立row
        let row1 = DemoRowObject(title: "Item", backgroundColor: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1), titleTextColor: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1))
        let row2 = DemoRowObject(title: "Item1", backgroundColor: #colorLiteral(red: 0.1921568627, green: 0.6705882353, blue: 0.7294117647, alpha: 1), titleTextColor: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1))
        let row3 = DemoRowObject(title: "Item2", backgroundColor: #colorLiteral(red: 0.3058218956, green: 0.8185168505, blue: 0.6672741771, alpha: 1), titleTextColor: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1))
        let row4 = DemoRowObject(title: "Item3", backgroundColor: #colorLiteral(red: 0.971321404, green: 0.3788147569, blue: 0.4026813209, alpha: 1), titleTextColor: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1))
        let row5 = DemoRowObject(title: "Item4", backgroundColor: #colorLiteral(red: 0.1254902035, green: 0.5176470876, blue: 0.7137255073, alpha: 1), titleTextColor: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1))
        let row6 = DemoRowObject(title: "Item5", backgroundColor: #colorLiteral(red: 0.971321404, green: 0.3788147569, blue: 0.4026813209, alpha: 1), titleTextColor: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1))
        /// 告訴section model, 這次需要什麼row
        /**
         EasyTableSection<這次需要什麼row>.init(rows:[這次row1, 這次row2....])
         */
        let section: DataType = EasyTableSection<DemoRowObject>.init(rows: [row1, row2, row3, row4, row5, row6])
        /// 將section分開放, 就可以租成多個section
        return [section]
    }
    
    /**
     - returns: Self, then you can do anything
     */
    @discardableResult
    public func updateMinimumLineSpacingForSection(_ minimum: @escaping CollectionMinimumLineSpacingForSection) -> Self {
        self.minimumLineSpacingForSection = minimum
        return self
    }
    
    /**
     - returns: Self, then you can do anything
     */
    @discardableResult
    public func updateMinimumInteritemSpacingForSection(_ minimum: @escaping CollectionMinimumInteritemSpacingForSection) -> Self {
        self.minimumInteritemSpacingForSection = minimum
        return self
    }
    
    /**
     - returns: Self, then you can do anything
     */
    @discardableResult
    public func updateInsetForSection(_ inset: @escaping CollectionInsetForSection) -> Self {
        self.insetForSection = inset
        return self
    }
    
    /**
     - returns: Self, then you can do anything
     */
    @discardableResult
    public func updateCellSize(_ size: @escaping CollectionCellSize) -> Self {
        self.cellSize = size
        return self
    }
    
    /**
     - returns: Self, then you can do anything
     */
    @discardableResult
    public func didSelectedCell(_ didSelected: @escaping CollectionSelectionCompletion) -> Self {
        self.selectedItem = didSelected
        return self
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].numberOfRows
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SampleCollectionCell.reuseIdentifier, for: indexPath) as? SampleCollectionCell else {
            return UICollectionViewCell()
        }
        if let object = self.data[checkIndexPath: indexPath] {
            cell.title = object.title
            cell.backgroundColor = object.backgroundColor
            cell.titleLabel.textColor = object.titleTextColor
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem?(indexPath, self.data[checkIndexPath: indexPath], collectionView.cellForItem(at: indexPath) as? SampleCollectionCell)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let cellSize = cellSize {
//            print("indexPath: \(indexPath), cellSize: \(cellSize(indexPath))")
            return cellSize(indexPath)
        } else {
            return .zero
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if let minimum = minimumLineSpacingForSection {
            return minimum(section)
        } else {
            return 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if let minimum = minimumInteritemSpacingForSection {
            return minimum(section)
        } else {
            return 0.0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if let inset = self.insetForSection {
            return inset(section)
        } else {
            return UIEdgeInsets.zero
        }
    }
}














