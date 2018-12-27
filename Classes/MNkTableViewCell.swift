//
//  MNkTableViewCell.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 27/12/18.
//

import UIKit
open class MNkTableViewCell:UITableViewCell{
    open func insertAndLayoutSubviews(){}
    open func config(){}
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        insertAndLayoutSubviews()
        backgroundColor = .white
        config()
    }
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





open class MNkTVCell_Parameter<T>:MNkTableViewCell{
    
    public var data:T?{
        didSet{
            guard let _data = data else{return}
            updateUI(with: _data)
        }
    }
    open func updateUI(with data:T){}
}
