//
//  CollectionCell1.swift
//  LLAdapterSwiftDemo
//
//  Created by renxun on 2018/11/5.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit
import SnapKit

class CollectionCell1: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func ll_updateUI() {
        print(self.ll_model)
    }
    
//    override func ll_updateUI() {
//        print(self.model)
//    }
}
