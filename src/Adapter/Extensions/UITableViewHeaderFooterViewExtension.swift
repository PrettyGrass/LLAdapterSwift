//
//  UITableViewHeaderFooterViewExtension.swift
//  LLAdapterSwift
//
//  Created by renxun on 2018/11/5.
//

@objc extension UITableViewHeaderFooterView {
    
    private struct AssociatedKeys {
        static var CellModelKey = "CellModelKey"
    }
    
    public var ll_model: LLTableSectionReusableCell? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.CellModelKey) as? LLTableSectionReusableCell
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.CellModelKey,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            ll_updateUI()
        }
    }
    
    open func ll_updateUI() {
        if let ext = ll_model?.kvcExt {
            for val in ext {
                self.setValue(val.value, forKeyPath: val.key)
            }
        }
    }

}

