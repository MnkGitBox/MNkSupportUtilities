//
//  MNkBaseViewController.swift
//  FBSnapshotTestCase
//
//  Created by MNk_Dev on 2/11/18.
//

import UIKit

open class MNkBaseVC<T>: UIViewController {
    
    public var data:T?{didSet{reloadData()}}

    open func insertAndLayoutSubviews(){}
    open func fetchData(){}
    open func reloadData(){}
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        insertAndLayoutSubviews()
        fetchData()
    }
}






