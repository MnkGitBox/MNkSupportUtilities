//
//  MNkBasicViewController.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 5/11/18.
//

import UIKit

open class MNkBasicViewController: UIViewController {
    
    open func insertAndLayoutSubviews(){}
    open func fetchData(){}
    open func updateUIWithNewData(){}
    open func config(){}
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        insertAndLayoutSubviews()
        config()
        fetchData()
        
    }
}
