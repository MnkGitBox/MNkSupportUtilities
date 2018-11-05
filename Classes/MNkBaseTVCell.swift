//
//  MNkBaseTVCell.swift
//  FBSnapshotTestCase
//
//  Created by MNk_Dev on 2/11/18.
//

import UIKit

open class MNkBaseTVCell<T>: UITableViewCell {
    
    public var data:T!{didSet{updateUI()}}
    
    open func insertAndLayoutSubviews(){}
    open func updateUI(){}
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        insertAndLayoutSubviews()
        backgroundColor = .white
    }
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
