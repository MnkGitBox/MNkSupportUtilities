//
//  UILabelExtension+Chain.swift
//  iDak
//
//  Created by Malith Nadeeshan on 4/4/20.
//  Copyright © 2020 Malith Nadeeshan. All rights reserved.
//

import UIKit

extension UIKitChain where Component : UILabel {
    
    @discardableResult
    public func text(_ text:String)->Self{
        component.text = text
        return self
    }
    
    @discardableResult
    public func atribText(_ text: NSAttributedString?) -> Self {
        component.attributedText = text
        return self
    }
    
    @discardableResult
    public func font(_ font:UIFont)->Self{
        component.font = font
        return self
    }
    
    @discardableResult
    public func textColor(_ color:UIColor)->Self{
        component.textColor = color
        return self
    }
    
    @discardableResult
    public func textAlignment(_ alignment:NSTextAlignment)->Self{
        component.textAlignment = alignment
        return self
    }
    
    @discardableResult
    public func numberOfLines(_ lines:Int)->Self{
        component.numberOfLines = lines
        return self
    }
    
}


