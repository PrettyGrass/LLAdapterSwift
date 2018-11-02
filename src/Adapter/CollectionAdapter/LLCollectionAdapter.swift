//
//  LLCollectionAdapter.swift
//  LLAdapterSwift
//
//  Created by renxun on 2018/10/31.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit

class LLCollectionAdapter:NSObject, LLAdapterProtocol {
    
    public typealias SectionType = LLCollectionSection
    /// 获取适配器中所有组
    public var sections: [LLCollectionSection] = []
    /// 刷新适配器
    public func reloadData() -> Void {
        
    }
    
    public func buildAddNewSection() -> LLCollectionSection {
        return LLCollectionSection()
    }
    
    public func buildAddNewSection<T>(Clazz clazz: T) -> LLCollectionSection where T : LLSectionProtocol {
        let section = LLCollectionSection()
        addSection(Section: section)
        return section
    }
    
    public func addSection(Section section: LLCollectionSection) -> Void {
        
    }
    
    public func insertSection(Section section: LLCollectionSection,index:Int) -> Void {
        
    }
    
    public func removeSection(Section section: LLCollectionSection) -> Void {
        
    }
}
