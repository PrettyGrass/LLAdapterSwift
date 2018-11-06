//
//  File.swift
//  LLAdapterSwift
//
//  Created by renxun on 2018/11/6.
//

 public class LLFlowCollectViewAdapter: LLCollectionAdapter,LLWaterFlowLayoutProtocol {
    
    public var flowLayout: LLWaterFlowLayout?
    
    public override init(collectionView: UICollectionView?) {
        super.init(collectionView: collectionView)
        self.congifLayout()
    }
    
    public convenience init(collectionView: UICollectionView?,flowLayout: LLWaterFlowLayout) {
        self.init(collectionView: collectionView)
        self.flowLayout = flowLayout
        self.congifLayout()
    }
    
    public func congifLayout() {
        if self.flowLayout == nil {
            self.flowLayout = LLWaterFlowLayout()
        }
        self.flowLayout!.delegate = self
        self.flowLayout!.customConfigWaterFlow()
        self.collectionView?.collectionViewLayout = self.flowLayout!
    }
}

extension LLFlowCollectViewAdapter {
    
    public func waterFlowLayoutForHeight(_ flowLayout: LLWaterFlowLayout ,At index:Int ,width: CGFloat) -> CGFloat {
        var aspectio: CGFloat = 1
        let section = self.sections.first
        if let cell = section?.cells[index] as? LLFlowCollectionCell {
            aspectio = cell.aspectRatio
            flowLayout.extraHeight = cell.extraHeight
        }
        return LLWaterFlowLayout.calculateCellHeight(aspectio, itemWidth: width)
    }
    
    public func collectionViewReferenceSizeHeader(_ collectionView: UICollectionView,flowLayout:LLWaterFlowLayout ,section: Int) -> CGSize {
        let section = self.sections.first
        return section?.sectionHeaderView?.itemSize ?? CGSize.zero
    }
    
    public func collectionViewReferenceSizeFooter(_ collectionView: UICollectionView,flowLayout:LLWaterFlowLayout ,section: Int) -> CGSize {
        let section = self.sections.first
        return section?.sectionFooterView?.itemSize ?? CGSize.zero
    }
}
