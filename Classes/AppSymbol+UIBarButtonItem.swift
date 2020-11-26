//
//  AppSymbol+UIBarButtonItem.swift
//  MNkSupportUtilities
//
//  Created by Malith Nadeeshan on 7/23/20.
//

import UIKit

//UIBarButtonItem Extension
//init Systom icon or old school symbol file
extension AppSymbol where Self : UIBarButtonItem {
    public func symbol(for name: AppSymbolNameType, _ font: UIFont) -> UIImage? {
        return Self.symbol(for: name)
    }
}

extension UIBarButtonItem : AppSymbol {}

extension UIBarButtonItem {
    public convenience init(symbol name: AppSymbolNameType) {
        self.init()
        image = symbol(for: name, UIFont.systemFont(ofSize: 20))
    }
}

extension UIBarButtonItem {
    public convenience init(_ image: UIImage) {
        self.init()
        self.image = image
    }
}
