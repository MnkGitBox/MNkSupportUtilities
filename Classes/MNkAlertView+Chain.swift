//
//  MNkAlertView+Chain.swift
//  iDak
//
//  Created by Malith Nadeeshan on 6/27/20.
//  Copyright © 2020 Malith Nadeeshan. All rights reserved.
//


extension UIKitChain where Component : MNkAlertView {
    
    ///Change Alert type. Default single controller.
    @discardableResult
    public func type(_ type: MNkAlertView.MNkAlertType) -> Self {
        component.type = type
        return self
    }
    
}
