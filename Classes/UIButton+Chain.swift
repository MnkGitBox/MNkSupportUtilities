//
//  UIButton+Chain.swift
//  iDak
//
//  Created by Malith Nadeeshan on 4/5/20.
//  Copyright © 2020 Malith Nadeeshan. All rights reserved.
//

import UIKit

public extension UIKitChain where Component: UIButton {
    
    @discardableResult
    func setImage(_ image:UIImage?,for state:UIControl.State = .normal) -> Self {
        component.setImage(image, for: state)
        return self
    }
    
    @discardableResult
    func title(_ title:String?,for state:UIControl.State = .normal) -> Self {
        component.setTitle(title, for: state)
        return self
    }
    
    @discardableResult
    func attributedTitle(_ title:NSAttributedString?,for state:UIControl.State = .normal) -> Self {
        component.setAttributedTitle(title, for: state)
        return self
    }
    
    @discardableResult
    func titleColor(_ color:UIColor,for state:UIControl.State = .normal) -> Self {
        component.setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult
    func titleAligment(_ aligment: NSTextAlignment) -> Self {
        component.titleLabel?.textAlignment = aligment
        return self
    }
    
    @discardableResult
    func font(_ font:UIFont) -> Self {
        component.titleLabel?.font = font
        return self
    }
    
    @discardableResult
    func imageContentMode( _ contentMode: UIView.ContentMode) -> Self {
        component.imageView?.contentMode = contentMode
        return self
    }
    
    @discardableResult
    func horizontalAdjusment( _ adjustment:UIControl.ContentHorizontalAlignment  ) -> Self {
        component.contentHorizontalAlignment = adjustment
        return self
    }
    
    @discardableResult
    func verticalAdjusment( _ adjustment:UIControl.ContentVerticalAlignment  ) -> Self {
        component.contentVerticalAlignment = adjustment
        return self
    }
    
    @discardableResult
    func imageEdgeInsets(_ insets: UIEdgeInsets) -> Self {
        component.imageEdgeInsets = insets
        return self
    }
    
    @discardableResult
    func titleEdgeInsets(_ insets: UIEdgeInsets) -> Self {
        component.titleEdgeInsets = insets
        return self
    }
    
    @discardableResult
    func contentInset(_ inset: UIEdgeInsets) -> Self {
        component.contentEdgeInsets = inset
        return self
    }
    
    @discardableResult
    func backgroundImage(_ image: UIImage?, for controlState: UIControl.State = .normal) -> Self {
        component.setBackgroundImage(image, for: controlState)
        return self
    }
}
