//
//  MNkSeperator+Chain.swift
//  iDak
//
//  Created by Malith Nadeeshan on 4/7/20.
//  Copyright © 2020 Malith Nadeeshan. All rights reserved.
//


extension UIKitChain where Component:MNkSeperator{
    
    @discardableResult
    public func height(_ height:CGFloat) -> Self {
        component.heightAnchorCons?.constant = height
        return self
    }

}
