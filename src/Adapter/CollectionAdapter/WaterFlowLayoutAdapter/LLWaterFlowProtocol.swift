//
//  LLWaterFlowProtocol.swift
//  LLAdapterSwift
//
//  Created by renxun on 2018/11/6.
//

@objc public protocol LLWaterFlowLayoutProtocol {
    
    func waterFlowLayoutForHeight(_ flowLayout: LLWaterFlowLayout ,At index:Int ,width: CGFloat) -> CGFloat
    
    @objc optional func collectionViewReferenceSizeHeader(_ collectionView: UICollectionView,flowLayout:LLWaterFlowLayout ,section: Int) -> CGSize
    @objc optional func collectionViewReferenceSizeFooter(_ collectionView: UICollectionView,flowLayout:LLWaterFlowLayout ,section: Int) -> CGSize
}
