//
//  MNkUIViewTVCompatable.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 15/11/18.
//
import UIKit
open class MNkUIViewTVCompatable<T,C:MNkBaseTVCell<T>>:MNkView,UITableViewDataSource,UITableViewDelegate{
    
    public lazy var tableView:UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(C.self, forCellReuseIdentifier: cellID)
        tv.tableFooterView = UIView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    public var cellID:String = "GenericCellID \(arc4random())"
    public var data:[T] = []{didSet{updateUIWithNewData()}}
    
    open override func insertAndLayoutSubviews() {
        addSubview(tableView)
        NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     tableView.topAnchor.constraint(equalTo: topAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! C
        cell.data = data[indexPath.item]
        return cell
    }
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    open func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {}
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {return nil}
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {return nil}
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {return 0}
}

