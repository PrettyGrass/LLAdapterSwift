//
//  LLTableSection.swift
//  LLAdapterSwift
//
//  Created by renxun on 2018/10/31.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit

public class LLTableSection: LLSectionProtocol {
    
    public typealias LLSectionHeaderType = UIView
    public typealias LLSectionFooterType = UIView
    public typealias LLCellType = LLTableCell
    
    public var sectionHeaderView: UIView?
    public var sectionFooterView: UIView?
    
    public var sectionHeaderViewHeight: CGFloat = 0
    public var sectionFooterViewHeight: CGFloat = 0
    
    public var cells: [LLTableCell] = []
    public var sectionIndex: Int?
    
    public var sectionHeaderTitle: String?
    public var sectionFooterTitle: String?
    
    public func addCell(cell: LLTableCell) {
        cells.append(cell)
    }
    
    public func addCell(TargetCell cell: LLTableCell, index: Int) {
        cells.insert(cell, at: index)
    }
    
    public func remove(TargetCell cell: LLTableCell) {
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
    
    public func buildAddCell() -> LLTableCell {
        let cell = LLTableCell()
        addCell(cell: cell)
        return cell
    }
    
    public func buildAddCell(CellClass clazz: AnyClass) -> LLTableCell {
        return LLTableCell()
    }
}
