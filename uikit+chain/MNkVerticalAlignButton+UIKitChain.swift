//
//  MNkVerticalAlignButton+UIKitChain.swift
//  iDak
//
//  Created by Malith Nadeeshan on 9/14/20.
//  Copyright © 2020 Malith Nadeeshan. All rights reserved.
//

public extension UIKitChain where Component: MNkVerticalAlignButton {
    @discardableResult
    func title(_ title: String) -> Self {
        component.titleLabel.text = title
        return self
    }
    
    @discardableResult
    func titleColor(_ color: UIColor) -> Self {
        component.titleLabel.textColor = color
        return self
    }
    
    @discardableResult
    func contentEdgeInset(_ inset: UIEdgeInsets) -> Self {
        component.contentEdgeInset = inset
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont) -> Self {
        component.titleLabel.font = font
        return self
    }
    
    @discardableResult
    func image(_ image: UIImage) -> Self {
        component.imageView.image = image
        return self
    }
    
    @discardableResult
    func spacing(_ space: CGFloat) -> Self {
        component.spacing = space
        return self
    }
    
    @discardableResult
    func imageEdgeInset(_ inset: UIEdgeInsets) -> Self {
        component.imageEdgeInset = inset
        return self
    }
}
