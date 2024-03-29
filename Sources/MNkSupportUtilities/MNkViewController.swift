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
    
    ///Edge Insets of the safeArea
    public var safeAreaEdgeInsets:UIEdgeInsets{
        guard let window = UIApplication.shared.windows.first else{return .zero}
        return window.safeAreaInsets
    }
    
    ///Rectangle area frame of the safeArea
    public var safeAreaRect: CGRect {
        guard let window = UIApplication.shared.windows.first else{return .zero}
        let frame = window.frame
        let safeAreaRect = CGRect.init(origin: .init(x: (frame.origin.x + safeAreaEdgeInsets.left),
                                                     y: (frame.origin.y + safeAreaEdgeInsets.top)),
                                       size: .init(width: frame.width - (safeAreaEdgeInsets.left + safeAreaEdgeInsets.right),
                                                   height: frame.height - (safeAreaEdgeInsets.top + safeAreaEdgeInsets.bottom)))
        return safeAreaRect
    }
    
    open func createViews(){}
    open func insertAndLayoutSubviews(){}
    open func fetchData(){}
    open func updateUIWithNewData(){}
    open func config(){}
    ///Call on viewWill Appear. Single exicution in UIViewController life cycle.
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
            guard !isDisplayOnce else { return }
            fetchData()
            
        case .always:
            fetchData()
        }
        
        if !isDisplayOnce {
            setAppSetting()
        }
        
        isDisplayOnce = true
    }
}



open class MNkViewController_Parameter<T>: MNkViewController {
    public var data:T?{didSet{updateUIWithNewData()}}
}
