//
//  MNkViewController.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 27/12/18.
//
import UIKit

open class MNkViewController: UIViewController {
    open func createViews(){}
    open func insertAndLayoutSubviews(){}
    open func fetchData(){}
    open func updateUIWithNewData(){}
    open func config(){}
    open func setAppSetting(){}
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createViews()
        insertAndLayoutSubviews()
        config()
        fetchData()
        
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAppSetting()
    }
}



open class MNkViewController_Parameter<T>: MNkViewController {
    public var data:T?{didSet{updateUIWithNewData()}}
}
