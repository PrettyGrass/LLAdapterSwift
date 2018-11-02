//
//  LLCollectionCell.swift
//  LLAdapterSwift
//
//  Created by renxun on 2018/10/31.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit

class LLCollectionCell: LLAdapterCellProtocol {
    
    var cellClazz: AnyClass = UICollectionViewCell.self
    
    private var _cellIdentity :String?
    
    var cellIdentity: String {
        get {
            if let id = _cellIdentity {
                return id
            }
            return (self.cellClazz as! NSObject.Type).ll_className()
        } set {
            _cellIdentity = newValue
        }
    }
    
    var data: Any?
    
    var kvcExt: [String : Any]?
    
    var indexPath: IndexPath?
    
    var cellNibName: String?
    
    var loadType: LLCellLoadType = LLCellLoadType.origin
    
}
