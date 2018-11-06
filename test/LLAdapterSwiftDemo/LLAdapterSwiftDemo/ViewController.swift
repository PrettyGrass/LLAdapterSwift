//
//  ViewController.swift
//  LLAdapterSwift
//
//  Created by renxun on 2018/10/31.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit
import LLAdapterSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var adapter: LLTableViewAdapter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .automatic
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        configTab()
    }
    
    func printClass(clazz: AnyClass) {
       let string = (clazz as! String.Type).init("吃货")
        print(string)
    }

    func configTab() -> Void {

        adapter = LLTableViewAdapter(TableView: tableView)
        let section1 = adapter!.buildAddNewSection()
        
        let pushCloseSure = {(targetVC: UIViewController) -> Void in
            self.navigationController?.pushViewController(targetVC, animated: true)
        }

        let cell1 = _creatCell(section: section1, cellHeight:60, text: "TableViewDemo")
        cell1.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        cell1.accessoryType = UITableViewCell.AccessoryType.checkmark
        cell1.cellClick = {(cell,indexPath) in
            
            let demoVC = TableViewDemo1(nibName: "TableViewDemo1", bundle: nil)
            pushCloseSure(demoVC)
        }

        let cell2 = _creatCell(section: section1, cellHeight:60, text: "CollectionViewDemo")
        cell2.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        cell2.accessoryType = UITableViewCell.AccessoryType.detailButton
        cell2.cellClick = {(cell,indexPath) in
            pushCloseSure(CollectionDemoList())
        }
        adapter?.reloadData()
    }

    func _creatCell(section: LLTableSection, cellHeight: CGFloat , text: String) -> LLTableCell {
        let cell = section.buildAddCell()
        cell.cellHeight = cellHeight
        cell.cellClazz = UITableViewCell.self
        cell.loadType = .origin
        cell.text = text
        cell.separatorStyle = .inner
        cell.selectionStyle = UITableViewCell.SelectionStyle.default
        cell.deSelectionStyle = LLDeSelectionStyle.now
        return cell
    }
}

