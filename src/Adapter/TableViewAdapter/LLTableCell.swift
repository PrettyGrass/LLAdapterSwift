//
//  LLTableCell.swift
//  LLAdapterSwift
//
//  Created by renxun on 2018/10/31.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit

open class LLTableCell: NSObject, LLAdapterCellProtocol {
    var data: Any?

    public var kvcExt: [String: Any]?

    var indexPath: IndexPath?

    public var cellClazz: AnyClass = UITableViewCell.self

    private var _cellIdentity: String?

    public var cellIdentity: String {
        get {
            if let id = _cellIdentity {
                return id
            }
            return (cellClazz as! NSObject.Type).ll_className()
        } set {
            _cellIdentity = newValue
        }
    }

    /// xib加载的时候必填
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

    public var loadType: LLCellLoadType = .origin

    /// cell高度
    public var cellHeight: CGFloat = UITableView.automaticDimension

    /// 附件风格
    public var accessoryType = UITableViewCell.AccessoryType.none

    /// 选中的样式
    public var selectionStyle = UITableViewCell.SelectionStyle.default

    /// 去选样式
    public var deSelectionStyle = LLDeSelectionStyle.now

    /// 行分割线
    public var separatorStyle = LLTableViewCellSeparatorStyle.none

    /// 分割线颜色
    public var spearatorColor = UIColor(red: 231 / 255, green: 231 / 255, blue: 231 / 255, alpha: 1)

    /// 分割线边距
    public var separatorInset: UIEdgeInsets = UIEdgeInsets.zero

    /// 点击事件
    public var cellClick: TableViewCellClick?

    /// 标题
    public var text: String?

    /// 子标题
    public var detailText: String?

    /// String or UIImage对象
    public var image: AnyObject?
}
