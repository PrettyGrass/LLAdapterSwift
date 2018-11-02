//
//  UITableViewCellExtensions.swift
//  LLAdapterSwift
//
//  Created by renxun on 2018/10/31.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit
import SnapKit

extension UITableViewCell {
    private struct AssociatedKeys {
        static var CellModelKey = "CellModelKey"
    }
   public var ll_model: LLTableCell? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.CellModelKey) as? LLTableCell
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.CellModelKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            ll_updateUI()
        }
    }
   public func ll_updateUI() {
        if let ext = ll_model?.kvcExt {
            for val in ext {
                self.setValue(val.value, forKeyPath: val.key)
            }
        }
        //处理原生cell 数据
        if NSStringFromClass(classForCoder) == "UITableViewCell" {
            self.textLabel?.text = ll_model?.text
            self.detailTextLabel?.text = ll_model?.detailText
            
            if ll_model?.image as? UIImage != nil {
                self.imageView?.image = ll_model?.image as? UIImage
            }else if ll_model?.image as? String != nil {
                self.imageView?.image = UIImage(named: ll_model?.image as! String)
            }
        }
        
        var separatorView = self.contentView.viewWithTag(10000)
    
        //处理分割线
        switch ll_model!.separatorStyle {
        case .none:
            separatorView?.removeFromSuperview()
            
        case .inner:
            if separatorView == nil {
                separatorView = UIView()
                separatorView?.backgroundColor = ll_model?.spearatorColor
               // separatorView?.frame = CGRect(x: 10, y: 10, width: 10, height: 10)
            }
            
            self.addSubview(separatorView!)
            
            let separatorInsert = ll_model!.separatorInset
            separatorView?.snp.makeConstraints({ (maker) in
                maker.left.equalToSuperview().offset(separatorInsert.left)
                maker.right.equalToSuperview().offset(-separatorInsert.right)
                maker.bottom.equalToSuperview().offset(-separatorInsert.bottom)
                maker.height.equalTo(0.5)
            })
            
        default:
            separatorView?.removeFromSuperview()
        }
        
    }

}

