//
//  UIImageView+Chain.swift
//  iDak
//
//  Created by Malith Nadeeshan on 4/5/20.
//  Copyright © 2020 Malith Nadeeshan. All rights reserved.
//

import UIKit

extension UIKitChain where Component:UIImageView{
    public var general:Self{
        component.contentMode = .scaleAspectFill
        component.clipsToBounds = true
        return self
    }
}
