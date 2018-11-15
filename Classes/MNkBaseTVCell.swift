//
//  MNkBaseTVCell.swift
//  FBSnapshotTestCase
//
//  Created by MNk_Dev on 2/11/18.
//
import UIKit
open class MNkBaseTVCell<T>: UITableViewCell {
    
    public var data:T?{
        didSet{
            guard let _data = data else{return}
            updateUI(with: _data)
        }
    }
    
    open func insertAndLayoutSubviews(){}
    open func updateUI(with data:T){}
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