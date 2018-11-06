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
       return self.dataSourceDelegate?.sectionIndexTitles?(for: tableView)
    }
    
    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
       return self.dataSourceDelegate?.tableView?(tableView, sectionForSectionIndexTitle: title, at: index) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.dataSourceDelegate?.tableView?(tableView, commit: editingStyle, forRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self.dataSourceDelegate?.tableView?(tableView, moveRowAt: sourceIndexPath, to: destinationIndexPath)
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
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.tableViewDelegate?.scrollViewDidScroll?(scrollView)
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.tableViewDelegate?.scrollViewDidZoom?(scrollView)
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.tableViewDelegate?.scrollViewWillBeginDragging?(scrollView)
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self.tableViewDelegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.tableViewDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
    
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView)  {
        self.tableViewDelegate?.scrollViewWillBeginDecelerating?(scrollView)
    }
    

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.tableViewDelegate?.scrollViewDidEndDecelerating?(scrollView)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.tableViewDelegate?.scrollViewDidEndScrollingAnimation?(scrollView)
    }
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.tableViewDelegate?.viewForZooming?(in: scrollView)
    }
 
    public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        self.tableViewDelegate?.scrollViewWillBeginZooming?(scrollView, with: view)
    }

    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        self.tableViewDelegate?.scrollViewDidEndZooming?(scrollView, with: view, atScale: scale)
    }
    
    public func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
       return self.tableViewDelegate?.scrollViewShouldScrollToTop?(scrollView) ?? false
    }

    public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        self.tableViewDelegate?.scrollViewDidScrollToTop?(scrollView)
    }

    @available(iOS 11.0, *)
    public func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        self.tableViewDelegate?.scrollViewDidChangeAdjustedContentInset?(scrollView)
        
    }

}
