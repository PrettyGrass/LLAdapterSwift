//
//  LLCollectionCell.swift
//  LLAdapterSwift
//
//  Created by renxun on 2018/10/31.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit

public class LLCollectionCell: NSObject,LLAdapterCellProtocol {
    
    public var cellClazz: AnyClass = UICollectionViewCell.self
    
    private var _cellIdentity :String?
    
    public var cellIdentity: String {
        get {
            if let id = _cellIdentity {
                return id
            }
            return (self.cellClazz as! NSObject.Type).ll_className()
        } set {
            _cellIdentity = newValue
        }
    }
    
    public var data: Any?
    
    public var kvcExt: [String : Any]?
    
    public var indexPath: IndexPath?
    
    var _cellNibName: String?
    public var cellNibName: String?  {
        get {
            if let id = _cellNibName {
                return id
            }
            return (self.cellClazz as! NSObject.Type).ll_className()
        } set {
            _cellNibName = newValue
        }
    }
    
    public var loadType: LLCellLoadType = LLCellLoadType.origin
    
    /// 图片名字或者URL
    public var image: Any?
    /// 标题
    public var title = "";
    /// 子标题
    public var subTitle = "";
    
    public var deSelectionStyle = LLDeSelectionStyle.none
    
    /// item大小
    public var itemSize: CGSize = CGSize.zero
    
    public var cellClick :CollectionCellClick?
    
}
