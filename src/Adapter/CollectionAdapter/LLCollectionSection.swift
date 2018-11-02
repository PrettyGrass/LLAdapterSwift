//
//  LLCollectionSection.swift
//  LLAdapterSwift
//
//  Created by renxun on 2018/10/31.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit

class LLCollectionSection: LLSectionProtocol {
    
    
    typealias LLSectionHeaderType = UICollectionReusableView
    typealias LLSectionFooterType = UICollectionReusableView
    
    typealias LLCellType = LLCollectionCell
    
    var cells: [LLCollectionCell] = []
    
    var sectionHeaderView: UICollectionReusableView?
    var sectionFooterView: UICollectionReusableView?
    
    var sectionHeaderCell: LLCollectionViewReusablecell?
    var sectionFooterCell: LLCollectionViewReusablecell?
    
    var sectionIndex: Int?
    
    public func addCell(cell: LLCollectionCell) {
        cells.append(cell)
        
    }
    
    public  func addCell(TargetCell cell: LLCollectionCell, index: Int) {
        cells.insert(cell, at: index)
        
    }
    
    public func remove(TargetCell cell: LLCollectionCell) {
        #warning ("可以用fillter尝试过滤")
        for (index , obj) in cells.enumerated() {
            if (obj === cell) {
                cells.remove(at: index)
            }
        }
    }
    
    public func remove(AtIndex index: Int) {
        cells.remove(at: index)
    }
    
    public func buildAddCell() -> LLCollectionCell {
        let cell = LLCollectionCell()
        addCell(cell: cell)
        return cell
    }
    
    public func buildAddCell(CellClass clazz: AnyClass) -> LLCollectionCell {
        return LLCollectionCell()
        
    }
}
