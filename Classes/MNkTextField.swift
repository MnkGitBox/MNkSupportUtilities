//
//  MNkTextField.swift
//  MNkSupportUtilities
//
//  Created by Malith Nadeeshan on 3/23/19.
//

import Foundation

open class MNkTextField: UITextField{
    
    public enum Edge{
        case top
        case bottom
        case left
        case right
    }
    
    public var borders:[Edge] = []{
        didSet{
            removeBorders()
            insertBorders()
        }
    }
    
    public var borderColor:UIColor = .red{
        didSet{
            changeBorderColors()
        }
    }
    
    private var borderViews:[UIView] = []
    
    private func insertBorders(){
        for edge in borders{
            insertBorder(to: edge)
        }
    }
    private func insertBorder(to edge:Edge){
        let border = UIView()
        border.backgroundColor = borderColor
        border.translatesAutoresizingMaskIntoConstraints = false
        addSubview(border)
        borderViews.append(border)
        
        switch edge{
        case .bottom:
            NSLayoutConstraint.activate([border.heightAnchor.constraint(equalToConstant: 1),
                                         border.leadingAnchor.constraint(equalTo: leadingAnchor),
                                         border.trailingAnchor.constraint(equalTo: trailingAnchor),
                                         border.bottomAnchor.constraint(equalTo: bottomAnchor)])
        case .top:
            NSLayoutConstraint.activate([border.heightAnchor.constraint(equalToConstant: 1),
                                         border.leadingAnchor.constraint(equalTo: leadingAnchor),
                                         border.trailingAnchor.constraint(equalTo: trailingAnchor),
                                         border.topAnchor.constraint(equalTo: topAnchor)])
        case .left:
            NSLayoutConstraint.activate([border.widthAnchor.constraint(equalToConstant: 1),
                                         border.leadingAnchor.constraint(equalTo: leadingAnchor),
                                         border.topAnchor.constraint(equalTo: topAnchor),
                                         border.bottomAnchor.constraint(equalTo: bottomAnchor)])
        case .right:
            NSLayoutConstraint.activate([border.widthAnchor.constraint(equalToConstant: 1),
                                         border.trailingAnchor.constraint(equalTo: trailingAnchor),
                                         border.topAnchor.constraint(equalTo: topAnchor),
                                         border.bottomAnchor.constraint(equalTo: bottomAnchor)])
        }
        
       
    }
    
    private func removeBorders(){
        for border in borderViews{
            border.removeFromSuperview()
        }
    }
    
    private func changeBorderColors(){
        for border in borderViews{
            border.backgroundColor = borderColor
        }
    }
}
