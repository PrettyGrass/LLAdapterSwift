//
//  CollectionDemoList.swift
//  LLAdapterSwiftDemo
//
//  Created by renxun on 2018/11/6.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit

class CollectionDemoList: BaseListViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LLCollectionAdapter的基础使用"
    }
    
    override func configCells() {
        
        let section =  self.adapter!.buildAddNewSection()
        
        let pushCloseSure = {(targetVC: UIViewController) -> Void in
            self.navigationController?.pushViewController(targetVC, animated: true)
        }
        
        AdapterUtil.creatCell(section: section, text: "collectionAdapter基础") { (cell, indexPath) in
            let demoVC = CollectionViewDemo1(nibName: "CollectionViewDemo1", bundle: nil)
            pushCloseSure(demoVC)
        }
        
        AdapterUtil.creatCell(section: section, text: "waterFlowAdapter使用") { (cell, indexPath) in
            let demoVC = CollectionViewDemo2(nibName: "CollectionViewDemo2", bundle: nil)
            pushCloseSure(demoVC)
        }
        
        AdapterUtil.creatCell(section: section, text: "自定义流水布局") { (cell, indexPath) in
            let demoVC = CollectionViewDemo3(nibName: "CollectionViewDemo3", bundle: nil)
            pushCloseSure(demoVC)
        }
        adapter?.reloadData()
    }
}
