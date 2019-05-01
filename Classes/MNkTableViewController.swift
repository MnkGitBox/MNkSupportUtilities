//
//  MNkTableViewController.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 27/12/18.
//

import UIKit

open class MNkTableViewController_Parameter_CellType<T,C:MNkTVCell_Parameter<T>>: MNkTableViewController_Parameter<T>{
    
    open override func config() {
        super.config()
        tableview.register(C.self, forCellReuseIdentifier: cellID)
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! C
        cell.data = data[indexPath.item]
        return tableview(tableview, updateCellDataWhenReloadingAt: indexPath, of: cell)
    }
    open func tableview(_ tableview:UITableView,updateCellDataWhenReloadingAt indexPath:IndexPath,of cell:C)->C{return cell}
}





open class MNkTableViewController_Parameter<T>:MNkTableViewController{
    
    public var data:[T] = [] {didSet{updateUIWithNewData()}}
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MNkTVCell_Parameter<T>
        cell.data = data[indexPath.item]
        return cell
    }
    
}



open class MNkTableViewController:MNkViewController,UITableViewDataSource,UITableViewDelegate{
    public var cellID:String =  "GenericCellID \(arc4random())"
    public var emptyCellID:String = "EmptyCellID \(arc4random())"
    
    public var tableview:UITableView!
    
    open override func createViews() {
        tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = .white
    }
    
    open override func insertAndLayoutSubviews() {
        view.addSubview(tableview)
        view.activateLayouts(to: self.view, true)
    }
    
    open override func config() {
        tableview.tableFooterView = UIView()
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return 0}
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {return UITableViewCell()}
    
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {return nil}
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {return 0}
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return UITableView.automaticDimension}
}
