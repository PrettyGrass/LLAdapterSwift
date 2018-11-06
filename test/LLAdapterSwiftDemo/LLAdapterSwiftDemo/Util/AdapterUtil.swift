//
//  AdapterUtil.swift
//  LLAdapterSwiftDemo
//
//  Created by renxun on 2018/11/6.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import LLAdapterSwift

class AdapterUtil {
    
    @discardableResult
    static func creatCell(section: LLTableSection,text: String ,cellClick:@escaping (LLTableCell,IndexPath) -> Void) -> LLTableCell {
        let cell = section.buildAddCell()
        cell.text = text
        cell.cellHeight = 50.0
        cell.cellClazz = UITableViewCell.self
        cell.cellClick = cellClick
        cell.separatorStyle = .inner
        return cell
    }
    
}
