//
//  MNkCollectionViewCell.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 27/12/18.
//
import UIKit

open class MNkCVCell_Parameter<T>: MNkCollectionViewCell {
    
    public var data:T?{
        didSet{
            guard let _data = data else{return}
            updateUI(with:_data)
        }
    }
    
    open func updateUI(with data:T){}
    
}





open class MNkCollectionViewCell:UICollectionViewCell{
    open func createViews(){}
    open func insertAndLayoutSubviews(){}
    open func config(){}
    
    private func doLoadThings(){
        backgroundColor = .white
        createViews()
        insertAndLayoutSubviews()
        config()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        doLoadThings()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doLoadThings()
    }
}
