//
//  MNkBaseTableVC.swift
//  FBSnapshotTestCase
//
//  Created by MNk_Dev on 2/11/18.
//

import UIKit
open class MNkBaseTableVC<T,C:MNkBaseTVCell<T>>: UITableViewController{
    
    public var data:[T] = []{didSet{tableView.reloadData()}}
    public var cellID:String{return "GenericCellID \(arc4random())"}
    
    open func configTableview(){
        tableView.register(C.self, forCellReuseIdentifier:cellID)
        tableView.dataSource = self
        tableView.delegate = self
    }
    open func fetchData(){}
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        configTableview()
        fetchData()
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return data.count}
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! C
        cell.data = data[indexPath.item]
        return cell
    }
}
