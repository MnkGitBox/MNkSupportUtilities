//
//  MNkCollectionViewCell.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 27/12/18.
//
import UIKit

open class MNkCVCell_Parameter<T>: UICollectionViewCell {
    
    public var data:T?{
        didSet{
            guard let _data = data else{return}
            updateUI(with:_data)
        }
    }
    
    open func updateUI(with data:T){}
    
}





open class MNkCollectionViewCell:UICollectionViewCell{
    open func insertAndLayoutSubviews(){}
    open func config(){}
    
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
