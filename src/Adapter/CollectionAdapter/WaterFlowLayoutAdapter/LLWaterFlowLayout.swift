//
//  LLWaterFlowLayout.swift
//  LLAdapterSwift
//
//  Created by renxun on 2018/11/6.
//

import UIKit

open class LLWaterFlowLayout: UICollectionViewFlowLayout {
    
    open weak var delegate: LLWaterFlowLayoutProtocol?
    /// 边缘间距
    open var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 10, right: 16)
    
    /// 每一列之间的间距
    open var lineMargin: CGFloat = 5.0
    
    /// 行间距
    open var rowMargin: CGFloat = 5.0
    
    /// 列数
    open var columnCount: Int = 3
    
    /// 额外高度,在代理计算完itemHeight时候 可以附加一些高度
    open var extraHeight: CGFloat = 0

    /// cell的所有布局属性
    private var attrsArray: [UICollectionViewLayoutAttributes] = []
    
    /// 所有列表当前的高度
    private var columnHeights: [CGFloat] = []
    
    ///内容的高度
    private var contentHeight: CGFloat = 0
    
    
    /// 子类可以按需求重写
    open func customConfigWaterFlow() {
        
        self.lineMargin = 13.0;
        self.rowMargin = 10.0;
        self.columnCount = 2;
        self.extraHeight = 0;
    }
    
    //MARK: 重写父类的布局
    
    open override func prepare() {
        super.prepare()
        
        //复原布局
        _resetLayout()
        //创建每一个cell对应的布局属性
        
        guard let section = self.collectionView?.numberOfSections else {
            return
        }
        for sectionIndex in 0..<section {
            
            let indexPath = IndexPath(item: 0, section: sectionIndex)
            
            //获取header的UICollectionViewLayoutAttributes
            if let headerAttrs = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath) {
                attrsArray.append(headerAttrs)
            }
            
            //获取cells布局属性
            guard let count = self.collectionView?.numberOfItems(inSection: sectionIndex) else {
                break
            }
            
            for itemIndex in 0..<count {
                //创建位置
                let indexPath = IndexPath(item: itemIndex, section: 0)
                
                //获取cell的布局属性
                if let cellAttrs = layoutAttributesForItem(at: indexPath) {
                    attrsArray.append(cellAttrs)
                }
            }
            
            //获取footer布局属性
            
            if let footerAttrs = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, at: indexPath) {
                attrsArray.append(footerAttrs)
            }
            
        }
    }
    
    open override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let isHeader = UICollectionView.elementKindSectionHeader == elementKind ? true : false
        //header
        let attr = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, with: indexPath)

        var size: CGSize?
        if (isHeader) {
            if let headerSize = self.delegate?.collectionViewReferenceSizeHeader?(collectionView!, flowLayout: self, section: indexPath.section)  {
                size = headerSize
            }else {
                size = CGSize.zero
            }
        }else {
            if let footerSize = self.delegate?.collectionViewReferenceSizeFooter?(collectionView!, flowLayout: self, section: indexPath.section) {
                size = footerSize
            }else {
                size = CGSize.zero
            }
        }
        
        if size!.equalTo(CGSize.zero) {
            return nil
        }
        
        let x: CGFloat = 0
        let y = contentHeight
        self.contentHeight = y + size!.height
        
        //更新对应列的高度
        for index in 0..<columnCount {
            self.columnHeights[index] = y + size!.height
        }
        attr.frame = CGRect(x: x, y: y, width: size!.width, height: size!.height)
        return attr
    }
    
    //MARK: 布局cell
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrsArray
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        let collectionViewWidth = self.collectionView!.frame.size.width
        
        let w = (collectionViewWidth - self.edgeInsets.left - self.edgeInsets.right - (CGFloat(self.columnCount - 1))*self.lineMargin) / CGFloat(columnCount)

        let h = self.delegate!.waterFlowLayoutForHeight(self, At: indexPath.item, width: w) + self.extraHeight
    
        //找出高度最短的那列
        var desColumn = 0
        var minColumnHeight = CGFloat.greatestFiniteMagnitude
        
        for index in 0..<self.columnCount {

            let height =  self.columnHeights[index]
            if minColumnHeight > height {
                minColumnHeight = height
                desColumn = index
            }
        }
        
        let x = self.edgeInsets.left + CGFloat(desColumn) * (w + self.lineMargin)
        
        var space: CGFloat = 0
        
        if indexPath.item < self.columnCount {
            //第一行
            space = self.edgeInsets.top
        }else {
            space = self.rowMargin
        }
        let y = minColumnHeight + space
        attrs.frame = CGRect(x: x, y: y, width: w, height: h)
        
        //更新最短的那列的高度
        self.columnHeights[desColumn] = attrs.frame.maxY
        
        //记录内容的高度
        let columnHeight = self.columnHeights[desColumn]
        if self.contentHeight < columnHeight {
            self.contentHeight = columnHeight
        }
        return attrs
    }
    
    open override var collectionViewContentSize: CGSize {
        get {
            if (self.contentHeight + self.edgeInsets.bottom) < UIScreen.main.bounds.height {
                return UIScreen.main.bounds.size
            }
            return CGSize(width: 0, height: self.contentHeight + self.edgeInsets.bottom)
        }
    }
}

extension LLWaterFlowLayout {
    
    /// 计算cell所需要的高度
    ///
    /// - Parameters:
    ///   - aspectRatio: 高宽比   height / width
    ///   - itemWidth: 宽度
    /// - Returns: 高度
   open class func calculateCellHeight(_ aspectRatio: CGFloat,itemWidth: CGFloat) -> CGFloat {
        return itemWidth * aspectRatio
    }
    
    private func _resetLayout() {
        
        //清除以前计算的高度
        self.columnHeights.removeAll()
        //默认高度
        for _ in 0...columnCount {
            columnHeights.append(0)
        }
        //清除之前所有的布局
        self.attrsArray.removeAll()
    }
}
