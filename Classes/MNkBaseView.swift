//
//  MNkBaseView.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 9/11/18.
//

import UIKit
open class MNkBaseView<T>:UIView{
    public var data:T!{didSet{updateUIWithNewData()}}
    open func insertAndLayoutSubviews(){}
    open func config(){}
    open func updateUIWithNewData(){}
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        insertAndLayoutSubviews()
        config()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
