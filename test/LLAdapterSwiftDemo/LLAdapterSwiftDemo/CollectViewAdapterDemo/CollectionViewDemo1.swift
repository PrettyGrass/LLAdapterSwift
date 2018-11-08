//
//  CollectionViewDemo1.swift
//  LLAdapterSwiftDemo
//
//  Created by renxun on 2018/11/5.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit
import LLAdapterSwift

class CollectionViewDemo1: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var adapter: LLCollectionAdapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CollectViewAdapter的使用"
        configFlowLayout()
    }
    
    func configFlowLayout() {
       let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 100)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.headerReferenceSize = CGSize(width: 300, height: 100)
        flowLayout.footerReferenceSize = CGSize(width: 300, height: 50)
        collectionView.collectionViewLayout = flowLayout
        
        adapter = LLCollectionAdapter(collectionView: collectionView)
        
        let section1 = adapter?.buildAddNewSection()
        
        let headerCell = LLCollectionCell()
        let footerCell = LLCollectionCell()
        
        headerCell.loadType = LLCellLoadType.nib
        headerCell.cellClazz = CollectionHeaderView.self
        headerCell.cellNibName = "CollectionHeaderView"
        
        footerCell.loadType = LLCellLoadType.nib
        footerCell.cellClazz = CollectionFooterView.self
        footerCell.cellNibName = "CollectionFooterView"
        
        section1?.sectionHeaderView = headerCell
        section1?.sectionFooterView = footerCell

        let cell1 = buildCell(Section: section1!, itemSize: CGSize(width: 100, height: 100))
        cell1.cellClick = {(cell,indexPath) in
            print(indexPath)
        }
        
        let cell2 = buildCell(Section: section1!, itemSize: CGSize(width: 100, height: 100))
        cell2.cellClick = {(cell,indexPath) in
            print(indexPath)
        }
        
        let cell3 = buildCell(Section: section1!, itemSize: CGSize(width: 100, height: 100))
        cell3.cellClick = {(cell,indexPath) in
            print(indexPath)
        }
        
        adapter?.reloadData()
    }
    
    func buildCell(Section section:LLCollectionSection,itemSize: CGSize) -> LLCollectionCell {
        let cell = section.buildAddCell()
        cell.cellClazz = CollectionCell1.self
        cell.loadType = .nib
        cell.itemSize = itemSize
        cell.cellNibName = "CollectionCell1"
        return cell
    }
}
