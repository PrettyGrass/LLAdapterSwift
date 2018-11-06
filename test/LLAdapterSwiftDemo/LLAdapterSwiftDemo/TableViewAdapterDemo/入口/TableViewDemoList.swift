//
//  TableViewDemoList.swift
//  LLAdapterSwiftDemo
//
//  Created by renxun on 2018/11/6.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit

class TableViewDemoList: BaseListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LLTableAdapter的基础使用"
    }
    
    override func configCells() {
        
        let section = adapter!.buildAddNewSection()
        
        let pushCloseSure = {(targetVC: UIViewController) -> Void in
            self.navigationController?.pushViewController(targetVC, animated: true)
        }
        
        AdapterUtil.creatCell(section: section, text: "自定义cell") { (cell, indexPath) in
    
            pushCloseSure(TableViewDemo1.init(nibName: "TableViewDemo1", bundle: nil) )
        }
        AdapterUtil.creatCell(section: section, text: "tableViewHeaderView的使用") { (cell, indexPath) in
            
        }
        AdapterUtil.creatCell(section: section, text: "tableView的可编辑 移动") { (cell, indexPath) in
            
        }
        AdapterUtil.creatCell(section: section, text: "tableView 通讯录列表") { (cell, indexPath) in
            
        }

        AdapterUtil.creatCell(section: section, text: "tableView滚动事件传递") { (cell, indexPath) in
            pushCloseSure(TableViewDemo2())

        }
        adapter?.reloadData()
        
    }


}
