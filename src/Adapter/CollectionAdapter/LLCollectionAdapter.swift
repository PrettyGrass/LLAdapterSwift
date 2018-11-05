//
//  LLCollectionAdapter.swift
//  LLAdapterSwift
//
//  Created by renxun on 2018/10/31.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit

public class LLCollectionAdapter:NSObject, LLAdapterProtocol,UICollectionViewDataSource,UICollectionViewDelegate {
    
    /// 获取适配器中所有组
    public var sections: [LLCollectionSection] = []
  
    weak var collectionView: UICollectionView? {
        didSet {
            collectionView?.delegate = self
            collectionView?.dataSource = self
        }
    }
    
    public init(collectionView: UICollectionView? = nil) {
        super.init()
        self.collectionView = collectionView
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
}

//MARK: LLAdapterProtocol

extension LLCollectionAdapter {

    public typealias SectionType = LLCollectionSection
    
    /// 刷新适配器
    public func reloadData() -> Void {
        collectionView?.reloadData()
    }
    
    public func buildAddNewSection() -> LLCollectionSection {
        let section = LLCollectionSection()
        sections.append(section)
        return section
    }
    
   public func buildAddNewSection(Clazz clazz: AnyClass) -> LLCollectionSection {
        if let section :LLCollectionSection = clazz.alloc() as? LLCollectionSection {
            sections.append(section)
            return section
        }
        let section = LLCollectionSection()
        sections.append(section)
        return section
    }
    
    public func buildAddNewSection(Cell cell: LLCollectionSection) {
        sections.append(cell)
    }
    
    public func addSection(Section section: LLCollectionSection) -> Void {
        sections.append(section)
    }
    
    public func insertSection(Section section: LLCollectionSection,index:Int) -> Void {
        sections.insert(section, at: index)
    }
    
    public func removeSection(Section section: LLCollectionSection) -> Void {
        
        for(index,obj) in sections.enumerated() {
            if obj === section {
                sections.remove(at: index)
            }
        }
    }
}

//MARK: UICollectionViewDataSource

extension LLCollectionAdapter {
    
  public  func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
  public  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    
   public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = sections[indexPath.section].cells[indexPath.row]
        
        switch model.loadType {
        case .nib:
            collectionView.register(UINib(nibName: model.cellNibName!,
                                          bundle: nil),
                                    forCellWithReuseIdentifier: model.cellIdentity)
        default:
            collectionView.register(model.cellClazz,
                                    forCellWithReuseIdentifier: model.cellIdentity)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:model.cellIdentity,for: indexPath)
        cell.model = model
        return cell
    }
}

//MARK: UICollectionViewDelegate
extension LLCollectionAdapter {
    
   public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = sections[indexPath.section].cells[indexPath.row]
        
        switch model.deSelectionStyle {
        case .now:
            collectionView.deselectItem(at: indexPath, animated: true)
        default:
            break
        }
        if let cellClick = model.cellClick {
            cellClick(model,indexPath)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let section = self.sections[indexPath.section]
        let reusableCell: LLCollectionViewReusableCell?
        
        if kind == UICollectionView.elementKindSectionHeader {
            reusableCell = section.sectionHeaderView
        } else if kind == UICollectionView.elementKindSectionFooter {
            reusableCell = section.sectionFooterView
        }else {
            return UICollectionReusableView()
        }
        let cellIdentity = reusableCell!.cellIdentity
        
        switch reusableCell!.loadType {
        case LLCellLoadType.inner:
            print("暂未实现")
            break
        case LLCellLoadType.nib:
            let reusableNib = UINib(nibName: reusableCell!.cellNibName!, bundle: nil)
            collectionView.register(reusableNib, forSupplementaryViewOfKind: kind, withReuseIdentifier: cellIdentity)
        default:
            collectionView.register(reusableCell!.cellClazz, forSupplementaryViewOfKind:kind, withReuseIdentifier: cellIdentity)
        }
        
        let resableView :UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellIdentity, for: indexPath)
        resableView.ll_model = reusableCell
        return resableView
    }

    
}


