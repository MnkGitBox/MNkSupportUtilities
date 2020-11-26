//
//  UIImageView+Chain.swift
//  iDak
//
//  Created by Malith Nadeeshan on 4/5/20.
//  Copyright © 2020 Malith Nadeeshan. All rights reserved.
//

import UIKit

extension UIKitChain where Component: UIImageView {
    
    ///Generic property set with -> clipsToBounds = true & contentMode = .scaleAspectFill
    public var general:Self{
        component.contentMode = .scaleAspectFill
        component.clipsToBounds = true
        return self
    }
    
    ///Set image to image view
    public func image(_ image: UIImage?) -> Self {
        component.image = image
        return self
    }
    
    ///Set image using image URL
    public func image(fromURL url: URL?) -> Self {
        component.sd_setImage(with: url, completed: nil)
        return self
    }
}
