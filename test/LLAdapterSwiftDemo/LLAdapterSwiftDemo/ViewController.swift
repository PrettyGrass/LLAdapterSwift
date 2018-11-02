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

        configTab()
    }

    func configTab() -> Void {

        adapter = LLTableViewAdapter(TableView: tableView)
        let section1 = adapter!.buildAddNewSection()

        let cell1 = _creatCell(Section: section1, cellHeight:40, text: "标题1")
        cell1.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        cell1.accessoryType = UITableViewCell.AccessoryType.checkmark

        let cell2 = _creatCell(Section: section1, cellHeight:50, text: "标题2")
        cell2.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        cell2.accessoryType = UITableViewCell.AccessoryType.detailButton

        let cell3 = _creatCell(Section: section1, cellHeight:55, text: "标题3")
        cell3.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        cell3.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

        let cell4 = _creatCell(Section: section1, cellHeight:61, text: "标题4")
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
        cell.cellClick = {(cell,indexPath) in
            print(cell,indexPath)
        }
        return cell
    }
}

