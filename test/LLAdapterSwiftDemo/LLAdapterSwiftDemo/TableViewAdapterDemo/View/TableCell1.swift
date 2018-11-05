//
//  TableCell1.swift
//  LLAdapterSwiftDemo
//
//  Created by renxun on 2018/11/5.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit

class TableCell1: UITableViewCell {
    override func ll_updateUI() {
        print("cell更新:",self.ll_model)
    }
}
