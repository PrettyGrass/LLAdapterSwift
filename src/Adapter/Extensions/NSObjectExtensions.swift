//
//  NSObjectExtensions.swift
//  LLAdapterSwift
//
//  Created by renxun on 2018/10/31.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import Foundation

extension NSObject {
    @discardableResult
    public func ll_className() -> String {
        let className = NSStringFromClass(type(of:self)).components(separatedBy: ".").last
        return className!
    }
    
    @discardableResult
    public static func ll_className() -> String {
        return  NSStringFromClass(type(of: self.init())).components(separatedBy: ".").last!
    }
    
}

