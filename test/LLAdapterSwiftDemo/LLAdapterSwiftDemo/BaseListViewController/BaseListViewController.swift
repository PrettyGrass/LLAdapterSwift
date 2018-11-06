//
//  BaseListViewController.swift
//  LLAdapterSwiftDemo
//
//  Created by renxun on 2018/11/6.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit

class BaseListViewController: UIViewController {

    var adapter: LLTableViewAdapter?
    let tableView = UITableView.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        configDemoTableView()
        configCells()
    }
    
    func configDemoTableView() -> Void {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.left.right.equalToSuperview()
            ConstraintMaker.bottom.equalTo(self.view)
            ConstraintMaker.top.equalTo(self.view)
        }
        adapter = LLTableViewAdapter(TableView: tableView)
    }

    func configCells() {}
}
