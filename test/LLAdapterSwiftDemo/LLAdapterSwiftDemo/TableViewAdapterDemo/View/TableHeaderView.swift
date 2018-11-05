//
//  HeaderView.swift
//  LLAdapterSwiftDemo
//
//  Created by renxun on 2018/11/5.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit

class TableHeaderView: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.orange
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "组头部"
        label.textColor = UIColor.white
        self.contentView.addSubview(label)
        
        label.snp.makeConstraints { (maker) in
            maker.top.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

