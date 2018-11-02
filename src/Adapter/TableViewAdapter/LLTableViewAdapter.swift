//
//  LLTableViewAdapter.swift
//  LLAdapterSwift
//
//  Created by renxun on 2018/10/31.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit

public class LLTableViewAdapter: NSObject {
    
    deinit {
        print("LLTableViewAdapter: deinit")
    }
    
   public typealias SectionType = LLTableSection

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
    
    private func setTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
    }
    
    public func reloadData() -> Void {
        self.tableView?.reloadData()
    }
}

extension LLTableViewAdapter: LLAdapterProtocol {
   public func buildAddNewSection() -> LLTableSection {
        let section = LLTableSection()
        sections.append(section)
        return section
    }
    
//    func buildAddNewSection<T: LLSectionProtocol>(Clazz clazz: AnyClass) -> T {
//        clazz.types()
//        
//    }
    
   public func addSection(Section section: LLTableSection) {
        
    }
    
   public func insertSection(Section section: LLTableSection, index: Int) {
        
    }
    
   public func removeSection(Section section: LLTableSection) {
        
    }
}

//MARK: UITableViewDataSource

extension LLTableViewAdapter: UITableViewDataSource {
  
   public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellSection =  self.sections[section]
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
        cell?.selectionStyle = model.selectionStyle
        cell?.ll_model = model
        cell?.accessoryType = model.accessoryType
        return cell!
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].sectionHeaderTitle
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].sectionFooterTitle
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        #warning ("暂未实现完")
        return false
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        #warning ("暂未实现完")

        return false
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        #warning ("暂未实现完")
        return []
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int  {
        #warning ("暂未实现完")
        return 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        #warning ("暂未实现完")

    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        #warning ("暂未实现完")
    }
}

//MARK: UITableViewDelegate
extension LLTableViewAdapter: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = sections[indexPath.section].cells[indexPath.row]
        switch model.deSelectionStyle {
        case .now:
            tableView.deselectRow(at: indexPath, animated: true)
        default: break
        }
        model.cellClick?(model,indexPath as NSIndexPath);
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = sections[indexPath.section].cells[indexPath.row]
        return model.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let model = sections[section]
        return model.sectionHeaderViewHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let model = sections[section]
        return model.sectionFooterViewHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sections[section].sectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return sections[section].sectionFooterView
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
}

extension LLTableViewAdapter {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return nil
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
    }
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return false
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        
    }
    
}


