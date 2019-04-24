//
//  MNkTableViewCell.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 27/12/18.
//

import UIKit
open class MNkTableViewCell:UITableViewCell{
    open func createViews(){}
    open func insertAndLayoutSubviews(){}
    open func config(){}
    
    open func setAppSetting(){}
    
    private func doLoadThings(){
        createViews()
        insertAndLayoutSubviews()
        backgroundColor = .white
        config()
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       doLoadThings()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doLoadThings()
    }
    
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        setAppSetting()
    }
}





open class MNkTVCell_Parameter<T>:MNkTableViewCell{
    
    open var data:T?{
        didSet{
            guard let _data = data else{return}
            updateUI(with: _data)
        }
    }
    open func updateUI(with data:T){}
}
