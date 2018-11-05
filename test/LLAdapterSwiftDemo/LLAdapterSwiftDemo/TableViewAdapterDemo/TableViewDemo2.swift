//
//  TableViewDemo2.swift
//  LLAdapterSwiftDemo
//
//  Created by renxun on 2018/11/5.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit

class TableViewDemo2: UITableViewController {
    
    var adapter: LLTableViewAdapter?

    override func viewDidLoad() {
        super.viewDidLoad()
        configTab()
    }
    
    func configTab() -> Void {
        
        adapter = LLTableViewAdapter(TableView: tableView)
        let section1 = adapter!.buildAddNewSection()
        
        let headerCell = LLTableSectionReusableCell()
        headerCell.cellClazz = TableHeaderView.self
        headerCell.cellHeight = 40
        
        let footerCell = LLTableSectionReusableCell()
        footerCell.cellClazz = TableFooterView.self
        footerCell.cellHeight = 30
        
        section1.sectionHeaderView = headerCell
        section1.sectionFooterView = footerCell

        let cell1 = _creatCell(Section: section1, cellHeight:100, text: "第一组:cell1")
        cell1.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        cell1.accessoryType = UITableViewCell.AccessoryType.checkmark
        
        let section2 = adapter!.buildAddNewSection()
        section2.sectionHeaderView = headerCell
        section2.sectionFooterView = footerCell
        
        let cell2 = _creatCell(Section: section2, cellHeight:150, text: "第二组:cell1")
        cell2.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        cell2.accessoryType = UITableViewCell.AccessoryType.detailButton
        adapter?.reloadData()
    }
    
    func _creatCell(Section: LLTableSection, cellHeight: CGFloat , text: String) -> LLTableCell {
        let cell = Section.buildAddCell()
        cell.cellHeight = cellHeight
        cell.cellClazz = TableCell1.self
        cell.loadType = .nib
        cell.cellNibName = "TableCell1"
        cell.text = text
        cell.separatorStyle = .inner
        cell.cellClick = {(cell,indexPath) in
            self.adapter?.reloadData()
        }
        return cell
    }
    
}
