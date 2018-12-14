//
//  MNKViewController_TV_Parameter.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 14/12/18.
//

import UIKit
open class MNKViewController_TV_Parameter<T>: MNkBasicViewController,UITableViewDataSource,UITableViewDelegate{

    public var data:[T] = [] {didSet{updateUIWithNewData()}}
    public var cellID:String{return "GenericCellID \(arc4random())"}
    
    public lazy var tableview:UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    open override func insertAndLayoutSubviews() {
        view.addSubview(tableview)
        NSLayoutConstraint.activate([tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MNkBaseTVCell<T>
        return cell
    }
}

