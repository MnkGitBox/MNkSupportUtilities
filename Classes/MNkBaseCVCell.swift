//
//  MNkBaseCVCell.swift
//  FBSnapshotTestCase
//
//  Created by MNk_Dev on 2/11/18.
//

import UIKit

open class MNkBaseCVCell<T>: UICollectionViewCell {
    
    public var data:T?{
        didSet{
            guard let _data = data else{return}
            updateUI(with:_data)
        }
    }
    
    open func insertAndLayoutSubviews(){}
    open func updateUI(with data:T){}
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        insertAndLayoutSubviews()
        backgroundColor = .white
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
