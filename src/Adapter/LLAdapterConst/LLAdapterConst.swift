//
//  LLAdapterConst.swift
//  LLAdapterSwift
//
//  Created by renxun on 2018/10/31.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import Foundation

/// Cell 加载方式
///
/// - inner: storyBoard构建的cell
/// - origin: 代码构建
/// - nib: xib加载
public enum LLCellLoadType :Int {
    case inner
    case origin
    case nib
}

/// 去选形式
///
/// - none: 不操作:
/// - now: 立即去选择:
/// - persist: 永久选择:
public enum LLDeSelectionStyle : Int {
    case none, now, persist
}

/// 分割线风格
///
/// - none: 无
/// - inner: 系统内置
/// - custom: 自定义
public enum LLTableViewCellSeparatorStyle: Int {
    case none, inner, custom
}


//点击事件
public typealias TableViewCellClick = (LLTableCell,NSIndexPath) -> Void
