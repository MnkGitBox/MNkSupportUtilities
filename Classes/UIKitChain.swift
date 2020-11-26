//
//  UIKitChain.swift
//  iDak
//
//  Created by Malith Nadeeshan on 4/4/20.
//  Copyright © 2020 Malith Nadeeshan. All rights reserved.
//

import Foundation

public struct UIKitChain<Component>{
    public let component:Component
    
    public init(_ component:Component) {
        self.component = component
    }
}

//MARK:- Chain Compatable Protocol
public protocol UIKitChainCompatable {
    
    associatedtype ComponentType
    
    var chain:UIKitChain<ComponentType> { get }
}

extension UIKitChainCompatable{
    
    public var chain:UIKitChain<Self> {
        get{
            return UIKitChain(self)
        }
    }
    
}


//MARK:-Add Chain Compatable to All NSObject SubClass Component
 extension NSObject: UIKitChainCompatable{}

import UIKit
//MARK:- General Implimentaion
extension UIKitChain where Component: UIView {
    
    @discardableResult
    public func bgColor(_ color:UIColor)->Self{
        component.backgroundColor = color
        return self
    }
    
    @discardableResult
    public func contentMode(_ mode:UIView.ContentMode)->Self{
        component.contentMode = mode
        return self
    }
    
    @discardableResult
    public func cornerRadius(_ radius:CGFloat)->Self{
        component.layer.cornerRadius = radius
        return self
    }
    
    @discardableResult
    public func cornerRadius(of radius: CGFloat, to corners: CACornerMask) -> Self {
        component.layer.cornerRadius = radius
        component.layer.maskedCorners = corners
        return self
    }
    
    @discardableResult
    public func clipToBounds(_ isClip:Bool) -> Self {
        component.clipsToBounds = isClip
        return self
    }
    
    @discardableResult
    public func userInteractionEnable(_ isEnable:Bool) -> Self {
        component.isUserInteractionEnabled = isEnable
        return self
    }
    
    @discardableResult
    public func tintColor(_ color:UIColor) -> Self {
        component.tintColor = color
        return self
    }
    
    @discardableResult
    public func frame( _ frame:CGRect ) -> Self {
        component.frame = frame
        return self
    }
    
    @discardableResult
    public func shadow(_ opacity:Float, _ offSet:CGSize = .init(width: 1, height: 1), _ radius:CGFloat = 4,_ color: UIColor = UIColor.black) -> Self {
        component.layer.shadowColor = color.cgColor
        component.layer.shadowOffset = offSet
        component.layer.shadowRadius = radius
        component.layer.shadowOpacity = opacity
        component.layer.masksToBounds = true
        self.clipToBounds(false)
        return self
    }
    
    @discardableResult
    public func border(_ color:UIColor,_ width:CGFloat = 0.5) -> Self {
        component.layer.borderColor = color.cgColor
        component.layer.borderWidth = width
        return self
    }
    
    @discardableResult
    public func border(edges: UIRectEdge, _ colors: UIColor, _ thikness: CGFloat = 1.0, _ inset: CGFloat = 0) -> Self {
        component.addBorders(edges: edges, color: colors, inset: inset, thickness: thikness)
        return self
    }
    
    @discardableResult
    public func activeAutoConstrant(_ isActive: Bool) -> Self {
        component.translatesAutoresizingMaskIntoConstraints = isActive
        return self
    }
    
    @discardableResult
    public func huggingPriority(_ priority: UILayoutPriority, _ axis: NSLayoutConstraint.Axis) -> Self {
        component.setContentHuggingPriority(priority, for: axis)
        return self
    }
    
    @discardableResult
    public func hidden(_ isHidden: Bool) -> Self {
        component.isHidden = isHidden
        return self
    }
}

