//
//  CollectionViewDemo3.swift
//  LLAdapterSwiftDemo
//
//  Created by renxun on 2018/11/6.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit
import LLAdapterSwift

class CollectionViewDemo3: UIViewController {

    var adapter : LLFlowCollectViewAdapter?
    
    @IBOutlet weak var collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "自定义FlowLayout"
        configCells()

    }
    
    func configCells() {
        
        //自定义: 继承 LLWaterFlowLayout 重写customConfigWaterFlow
        let myLayout = CustomFlowLayout()
        
        adapter = LLFlowCollectViewAdapter(collectionView: collection, flowLayout: myLayout)
        let section = adapter!.buildAddNewSection()
        
        //section头,section尾
        let headerCell = LLCollectionCell()
        let footerCell = LLCollectionCell()
        
        headerCell.loadType = LLCellLoadType.nib
        headerCell.cellClazz = CollectionHeaderView.self
        headerCell.cellNibName = "CollectionHeaderView"
        headerCell.itemSize = CGSize(width: 375, height: 100)
        
        footerCell.loadType = LLCellLoadType.nib
        footerCell.cellClazz = CollectionFooterView.self
        footerCell.cellNibName = "CollectionFooterView"
        footerCell.itemSize = CGSize(width: 375, height: 50)
        
        section.sectionHeaderView = headerCell
        section.sectionFooterView = footerCell
        
        let list :[CGFloat] = [16/9,1,9/16,8/3,3/8,16/6,16/9,16/9,16/9,16/9,16/9,16/9,16/9,16/9]
        for index in 0...10 {
            let flowCell = LLFlowCollectionCell()
            section.addCell(cell: flowCell)
            flowCell.aspectRatio = list[index]
            flowCell.cellClazz = CollectionCell1.self
            flowCell.loadType = .nib
            flowCell.extraHeight = 30
            flowCell.cellNibName = "CollectionCell1"
            flowCell.cellClick = {(cell,indexPath) in
                print(cell,indexPath)
            }
        }
        adapter?.reloadData()
    }



}
