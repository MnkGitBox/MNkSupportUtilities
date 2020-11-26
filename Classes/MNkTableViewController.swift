//
//  MNkTableViewController.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 27/12/18.
//

import UIKit
/*............................................................
 MARK:- MNkTableView controllers with normal cell type reload
 ............................................................*/
open class MNkTableViewController_Parameter_CellType<T,C:MNkTVCell_Parameter<T>>: MNkTableViewController_Parameter<T>{
    
    open override func config() {
        super.config()
        tableview.register(C.self, forCellReuseIdentifier: cellID)
    }
    
    dynamic open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! C
        cell.data = data[indexPath.item]
        return tableview(tableview, updateCellDataWhenReloadingAt: indexPath, of: cell)
    }
    dynamic open func tableview(_ tableview:UITableView,updateCellDataWhenReloadingAt indexPath:IndexPath,of cell:C)->C{return cell}
}

open class MNkTableViewController_Parameter<T>:MNkTableViewController{
    
    public var data:[T] = [] {didSet{updateUIWithNewData()}}
    
    dynamic open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
}

open class MNkTableViewController: MNkViewController,
                                   UITableViewDataSource,
                                   UITableViewDelegate {
    public var cellID:String =  "GenericCellID \(arc4random())"
    public var emptyCellID:String = "EmptyCellID \(arc4random())"
    
    public var tableview:UITableView!
    
    public var cellDisplayViewBounds:CGRect{
        let topPadding = (navigationController?.navigationBar.frame.size.height ?? 0) + safeAreaEdgeInsets.top
        let bottomPadding = (tabBarController?.tabBar.frame.size.height ?? 0) + safeAreaEdgeInsets.bottom
        let mainSreenRect = UIScreen.main.bounds
        return CGRect.init(origin: .zero,
                           size: CGSize.init(width: mainSreenRect.width,
                                             height: mainSreenRect.height - topPadding - bottomPadding))
    }
    
    open override func createViews() {
        tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = .white
    }
    
    open override func insertAndLayoutSubviews() {
        view.addSubview(tableview)
        tableview.activateLayouts(to: self.view)
    }
    
    open override func config() {
        tableview.tableFooterView = UIView()
    }
    
    dynamic open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    dynamic open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return 0}
    dynamic open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {return UITableViewCell()}
    
    dynamic open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {return nil}
    dynamic open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {return 0}
    dynamic open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return UITableView.automaticDimension}
}





/*...........................................................
 MARK:- MNkTableView controllers with empty cell type reload
 ............................................................*/
open class MNkTVC_Parameter_Cell_EmptyCellType<T,C:MNkTVCell_Parameter<T>,E:MNkEmptyTVCell>:MNkTVC_Parameter_EmptyCellType<T,E>{
    
    dynamic open override func config() {
        super.config()
        tableview.register(C.self, forCellReuseIdentifier: cellID)
    }
    
    dynamic open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard setEmptyCell else{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! C
            cell.data = data[indexPath.item]
            return tableview(tableview, updateCellDataWhenReloadingAt: indexPath, of: cell)
        }
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    dynamic open func tableview(_ tableview:UITableView,updateCellDataWhenReloadingAt indexPath:IndexPath,of cell:C)->C{return cell}
}


open class MNkTVC_Parameter_EmptyCellType<T,E:MNkEmptyTVCell>:MNkTVC_EmptyCellType<E>{
    public private(set) var setEmptyCell = false
    
    public var data:[T] = [] {
        didSet{
            setEmptyCell = data.isEmpty
            updateUIWithNewData()
        }
    }
   
    dynamic open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard setEmptyCell else {return data.count}
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    dynamic open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let emptyCell = tableView.dequeueReusableCell(withIdentifier: emptyCellID, for: indexPath) as! E
        emptyCell.delegate = self
        emptyCell.height = cellDisplayViewBounds.size.height
        return self.tableview(setEmptyCellData: emptyCell, at: indexPath)
    }
    
    dynamic open func tableview(setEmptyCellData emptyCell:E,at indexPath:IndexPath)->E{return emptyCell}
}

extension MNkTVC_Parameter_EmptyCellType:EmptyTableviewDelegate{
    public func userDidTappedReloadData(_ button: UIButton, in cell: MNkEmptyTVCell) {}
}

open class MNkTVC_EmptyCellType<E:MNkEmptyTVCell>:MNkTableViewController{
    open override func config() {
        super.config()
        tableview.register(E.self, forCellReuseIdentifier: emptyCellID)
    }

    dynamic open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
