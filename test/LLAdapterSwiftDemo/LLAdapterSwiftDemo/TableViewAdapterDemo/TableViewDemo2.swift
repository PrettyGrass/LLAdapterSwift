//
//  TableViewDemo2.swift
//  LLAdapterSwiftDemo
//
//  Created by renxun on 2018/11/5.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit

class TableViewDemo2: BaseListViewController,UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "滚动事件传递"
    }
    
    override func configCells() {
        let section = adapter!.buildAddNewSection()
        for _ in 0...100 {
            AdapterUtil.creatCell(section: section, text: "cell") { (cell, indexPath) in
            }
        }
        adapter?.reloadData()
        
        //设置tableViewDelegate 可以回调scrollerDelegate事件,以及部分tableView代理事件
        adapter?.tableViewDelegate = self
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll.......")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
}
