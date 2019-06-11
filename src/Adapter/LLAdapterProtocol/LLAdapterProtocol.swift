//
//  LLAdapterProtocol.Swift
//  LLAdapterSwift
//
//  Created by renxun on 2018/10/31.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import Foundation
import UIKit

public protocol LLAdapterProtocol {
    
    associatedtype SectionType
    /// 获取适配器中所有组
    var sections: [SectionType] { set get }
    /// 刷新适配器
    func reloadData() -> Void;
    
    func buildAddNewSection() -> SectionType
    
    func buildAddNewSection(Cell cell: SectionType) -> Void;
    
    func addSection(Section section: SectionType) -> Void;
    
    func insertSection(Section section: SectionType,index:Int) -> Void
    
    func removeSection(Section section: SectionType) -> Void
}

public protocol LLSectionProtocol {
    
    associatedtype LLCellType
    associatedtype LLSectionHeaderType
    associatedtype LLSectionFooterType
    
    /// 所有的cell合集
     var cells: [LLCellType] {get set}
    
    /// 组头
     var sectionHeaderView: LLSectionHeaderType? {get set}
    
    /// 组尾
     var sectionFooterView: LLSectionFooterType? {get set}
    
    /// 组索引
     var sectionIndex: Int? {get set}
    
    /// 添加一个cell
     func addCell(cell:LLCellType) -> Void
    
    /// 插入一个cell
     func addCell(TargetCell cell:LLCellType ,index: Int) -> Void
    
    /// 移除指定的cell
     func remove(TargetCell cell:LLCellType) -> Void
    
    /// 移除某行的cell
     func remove(AtIndex index: Int) -> Void
    
    /// 构建并添加一个默认新的cell对象
     func buildAddCell() -> LLCellType
    
    /// 通过cell类型构建并添加一个cell对象
     func buildAddCell(CellClass clazz: AnyClass) -> LLCellType
}

public protocol LLAdapterCellProtocol {
    /// 数据: 支持结构体,枚举等任何类型
     var data :Any? {get set}
    /// kvc 透传数据
     var kvcExt: [String: Any]  {get set}
    /// 行索引信息
      var indexPath: IndexPath?  {get set}
    ///cell类
     var cellClazz: AnyClass  {get set}
    ///重用id 默认是 cellClazz类的类名
     var cellIdentity: String  {get set}
    /// cell 默认是 cellClazz类的类名
     var cellNibName: String?  {get set}
    /// cell加载类型
     var loadType: LLCellLoadType  {get set}
    
}

