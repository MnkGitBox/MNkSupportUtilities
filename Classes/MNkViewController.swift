//
//  MNkViewController.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 27/12/18.
//
import UIKit

open class MNkViewController: UIViewController {
    
    public enum RepeatState {
        case once, always
    }
    
    open var fetchingState: RepeatState {
        .once
    }
    
    public private(set)var isDisplayOnce = false
    
    public var safeAreaEdgeInsets:UIEdgeInsets{
        guard let window = UIApplication.shared.windows.first else{return .zero}
        return window.safeAreaInsets
    }
    
    open func createViews(){}
    open func insertAndLayoutSubviews(){}
    open func fetchData(){}
    open func updateUIWithNewData(){}
    open func config(){}
    open func setAppSetting(){}
    
    private func doLoadThings(){
        view.backgroundColor = .white
        config()
    }
    
    open override func loadView() {
        super.loadView()
        createViews()
        insertAndLayoutSubviews()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        doLoadThings()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch fetchingState {
        case .once:
            setAppSetting()
            guard !isDisplayOnce else { return }
            fetchData()
            
        case .always:
            fetchData()
        }
        
        isDisplayOnce = true
    }
}



open class MNkViewController_Parameter<T>: MNkViewController {
    public var data:T?{didSet{updateUIWithNewData()}}
}
