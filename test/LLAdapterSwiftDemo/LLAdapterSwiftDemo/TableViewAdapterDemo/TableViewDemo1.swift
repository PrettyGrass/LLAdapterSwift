//
//  TableViewDemo1.swift
//  LLAdapterSwiftDemo
//
//  Created by renxun on 2018/11/5.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit

class TableViewDemo1: UITableViewController {
    
    var adapter: LLTableViewAdapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTab()
        
    }
    
    func configTab() -> Void {
        
        adapter = LLTableViewAdapter(TableView: tableView)
        let section1 = adapter!.buildAddNewSection()
        
        
        let pushCloseSure = {(targetVC: UIViewController) -> Void in
            self.navigationController?.pushViewController(targetVC, animated: true)
        }
        
        let cell1 = _creatCell(Section: section1, cellHeight:60, text: "自定义cell")
        cell1.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        cell1.cellClick = {(cell,indexPath) in
            let demoVC = TableViewDemo2(nibName: "TableViewDemo2", bundle: nil)
            pushCloseSure(demoVC)
        }
        cell1.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

        let cell2 = _creatCell(Section: section1, cellHeight:60, text: "tableViewHeaderView的使用")
        cell2.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        cell2.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

        let cell3 = _creatCell(Section: section1, cellHeight:60, text: "tableView的可编辑 移动")
        cell3.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        cell3.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        let cell4 = _creatCell(Section: section1, cellHeight:60, text: "tableView 通讯录列表")
        cell4.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 10)
        adapter?.reloadData()
    }
    
    func _creatCell(Section: LLTableSection, cellHeight: CGFloat , text: String) -> LLTableCell {
        let cell = Section.buildAddCell()
        cell.cellHeight = cellHeight
        cell.cellClazz = UITableViewCell.self
        cell.loadType = .origin
        cell.text = text
        cell.separatorStyle = .inner
        return cell
    }
  
    
}
