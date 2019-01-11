//
//  MNkViewController.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 27/12/18.
//
import UIKit

open class MNkViewController: UIViewController {
    
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



open class MNkViewController_Parameter<T>: MNkViewController {
    public var data:T?{didSet{updateUIWithNewData()}}
}
