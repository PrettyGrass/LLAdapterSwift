//
//  LLCollectionCell.swift
//  LLAdapterSwift
//
//  Created by renxun on 2018/10/31.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit

open class LLCollectionCell: NSObject,LLAdapterCellProtocol {
    
    open var cellClazz: AnyClass = UICollectionViewCell.self
    
    private var _cellIdentity :String?
    
    open var cellIdentity: String {
        get {
            if let id = _cellIdentity {
                return id
            }
            return (self.cellClazz as! NSObject.Type).ll_className()
        } set {
            _cellIdentity = newValue
        }
    }
    
    open var data: Any?
    
    open var kvcExt: [String : Any] = [:]
    
    open var indexPath: IndexPath?
    
    var _cellNibName: String?
    open var cellNibName: String?  {
        get {
            if let id = _cellNibName {
                return id
            }
            return (self.cellClazz as! NSObject.Type).ll_className()
        } set {
            _cellNibName = newValue
        }
    }
    
    open var loadType: LLCellLoadType = LLCellLoadType.origin
    
    /// 图片名字或者URL
    open var image: Any?
    /// 标题
    open var title = "";
    /// 子标题
    open var subTitle = "";
    
    open var deSelectionStyle = LLDeSelectionStyle.none
    
    /// item大小
    open var itemSize: CGSize = CGSize.zero
    
    open var cellClick :CollectionCellClick?
    
}
