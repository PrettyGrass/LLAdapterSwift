//
//  CustomFlowLayout.swift
//  LLAdapterSwiftDemo
//
//  Created by renxun on 2018/11/6.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit
import LLAdapterSwift

class CustomFlowLayout: LLWaterFlowLayout {
    
    override func customConfigWaterFlow() {
        self.lineMargin = 10;
        self.rowMargin = 10.0;
        self.columnCount = 3;
        self.extraHeight = 0;
    }
}
