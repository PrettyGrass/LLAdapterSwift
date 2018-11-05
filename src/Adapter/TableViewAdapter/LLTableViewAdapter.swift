//
//  LLTableViewAdapter.swift
//  LLAdapterSwift
//
//  Created by renxun on 2018/10/31.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit

public class LLTableViewAdapter: NSObject,LLAdapterProtocol, UITableViewDataSource, UITableViewDelegate {
    deinit {
        print("LLTableViewAdapter: deinit")
    }

    /// 获取适配器中所有组
    public var sections: [SectionType] = []
    /// 刷新适配器

    public weak var tableViewDelegate: UITableViewDelegate?
    public weak var dataSourceDelegate: UITableViewDataSource?

    public weak var tableView: UITableView? {
        didSet {
            setTableView()
        }
    }

    public init(TableView tableView: UITableView? = nil) {

        super.init()
        self.tableView = tableView
        setTableView()
    }

    func setTableView() {
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.separatorStyle = .none
    }
}

//MARK:LLAdapterProtocol

extension LLTableViewAdapter {
    
    public typealias SectionType = LLTableSection
    
    public func reloadData() {
        tableView?.reloadData()
    }
    
    public func buildAddNewSection(Cell cell: LLTableSection) -> Void {
        sections.append(cell)
    }
    
    public func buildAddNewSection() -> LLTableSection {
        let section = LLTableSection()
        sections.append(section)
        return section
        //return buildAddNewSection(Clazz: LLTableSection.self)
    }
    
    public func buildAddNewSection(Clazz clazz: AnyClass) -> LLTableSection {
        let section1 = (clazz as! LLTableSection.Type).init()
        print(section1)
        if let section: LLTableSection = clazz.alloc() as? LLTableSection {
            sections.append(section)
            return section
        }
        let section = LLTableSection()
        sections.append(section)
        return section
    }
    
    public func addSection(Section section: LLTableSection) {
        sections.append(section)
    }
    
    public func insertSection(Section section: LLTableSection, index: Int) {
        sections.insert(section, at: index)
    }
    
    public func removeSection(Section section: LLTableSection) {
        for (index, obj) in sections.enumerated() {
            if obj === section {
                sections.remove(at: index)
            }
        }
    }
}

//MARK: UITableViewDatasource

extension LLTableViewAdapter {
    
    public func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellSection = sections[section]
        return cellSection.cells.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].cells[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentity)
        if cell == nil {
            switch model.loadType {
            case LLCellLoadType.nib:
                tableView.register(UINib(nibName: model.cellNibName!, bundle: nil), forCellReuseIdentifier: model.cellIdentity)
            default:
                tableView.register(model.cellClazz, forCellReuseIdentifier: model.cellIdentity)
            }
            cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentity)
        }
        model.indexPath = indexPath
        cell?.ll_model = model
        cell?.accessoryType = model.accessoryType
        cell?.selectionStyle = model.selectionStyle
        return cell!
    }
    
    public func numberOfSections(in _: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].sectionHeaderTitle
    }
    
    public func tableView(_: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].sectionFooterTitle
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        #warning("暂未实现完")
        guard let dataSource = self.dataSourceDelegate else {
            return nil
        }
        return nil
    }
    
    public func tableView(_: UITableView, sectionForSectionIndexTitle _: String, at _: Int) -> Int {
        #warning("暂未实现完")
        return 0
    }
    
    public func tableView(_: UITableView, commit _: UITableViewCell.EditingStyle, forRowAt _: IndexPath) {
        #warning("暂未实现完")
    }
    
    public func tableView(_: UITableView, moveRowAt _: IndexPath, to _: IndexPath) {
        #warning("暂未实现完")
    }
}

//MARK: UITableViewDelegate
extension LLTableViewAdapter {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = sections[indexPath.section].cells[indexPath.row]
        switch model.deSelectionStyle {
        case .now:
            tableView.deselectRow(at: indexPath, animated: true)
        default: break
        }
        model.cellClick?(model, indexPath)
    }
    
    public func tableView(_: UITableView, didDeselectRowAt _: IndexPath) {}
    
    public func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = sections[indexPath.section].cells[indexPath.row]
        return model.cellHeight
    }
    
    public func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let model = sections[section]
        model.sectionIndex = section
        return model.sectionHeaderView?.cellHeight ?? 0
    }
    
    public func tableView(_: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let model = sections[section]
        model.sectionIndex = section
        return model.sectionFooterView?.cellHeight ?? 0
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerCell = sections[section].sectionHeaderView {
            return _congifHeaderFooterView(tableView, cell: headerCell)
        }else {
            return nil
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let footerCell = sections[section].sectionFooterView {
            return _congifHeaderFooterView(tableView, cell: footerCell)
        }else {
            return nil
        }
    }
    
    public func _congifHeaderFooterView(_ tableView:UITableView ,cell: LLTableSectionReusableCell ) -> UIView? {
        switch cell.loadType {
        case .inner:
            break
        case .nib:
            let nibClass = UINib(nibName: cell.cellNibName!, bundle: nil)
            tableView.register(nibClass, forHeaderFooterViewReuseIdentifier: cell.cellIdentity)
        default:
           tableView.register(cell.cellClazz, forHeaderFooterViewReuseIdentifier: cell.cellIdentity)
        }
        let headerFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: cell.cellIdentity)
        headerFooterView?.ll_model = cell
        return headerFooterView
    }
    
    public func tableView(_: UITableView, editingStyleForRowAt _: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
}

extension LLTableViewAdapter {
    
    public func scrollViewDidScroll(_: UIScrollView) {}
    
    public func scrollViewDidZoom(_: UIScrollView) {}
    
    public func scrollViewWillBeginDragging(_: UIScrollView) {}
    
    public func scrollViewWillEndDragging(_: UIScrollView, withVelocity _: CGPoint, targetContentOffset _: UnsafeMutablePointer<CGPoint>) {}
    
    public  func scrollViewDidEndDragging(_: UIScrollView, willDecelerate _: Bool) {}
    
    public func scrollViewWillBeginDecelerating(_: UIScrollView) {}
    
    public func scrollViewDidEndDecelerating(_: UIScrollView) {}
    
    public  func scrollViewDidEndScrollingAnimation(_: UIScrollView) {}
    
    public  func viewForZooming(in _: UIScrollView) -> UIView? {
        return nil
    }
    
    public func scrollViewWillBeginZooming(_: UIScrollView, with _: UIView?) {}
    
    public  func scrollViewDidEndZooming(_: UIScrollView, with _: UIView?, atScale _: CGFloat) {}
    
    public  func scrollViewShouldScrollToTop(_: UIScrollView) -> Bool {
        return false
    }
    
    public  func scrollViewDidScrollToTop(_: UIScrollView) {}
    
    public func scrollViewDidChangeAdjustedContentInset(_: UIScrollView) {}
}
