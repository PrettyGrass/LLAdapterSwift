//
//  ViewController.swift
//  LLAdapterSwift
//
//  Created by renxun on 2018/10/31.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit
import LLAdapterSwift

class ViewController: BaseListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .automatic
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        title = "适配器Demo"
    }

    //重写
    override func configCells() {
        
        let section1 = adapter!.buildAddNewSection()

        // 自动闭包
        let pushCloseSure = {(targetVC: UIViewController) -> Void in
            self.navigationController?.pushViewController(targetVC, animated: true)
        }
        
        AdapterUtil.creatCell(section: section1, text: "LLTableAdapterDemo") { (cell, indexPath) in
            pushCloseSure(TableViewDemoList())
        }
        AdapterUtil.creatCell(section: section1, text: "LLCollectionAdapterDemo") { (cell, indexPath) in
            pushCloseSure(CollectionDemoList())
        }
        //刷新列表数据
        adapter?.reloadData()
    }

}

