//
//  AppSymbol+UIimageView.swift
//  MNkSupportUtilities
//
//  Created by Malith Nadeeshan on 7/23/20.
//

import UIKit

public extension AppSymbol where Self: UIImageView {
    
///    Will return symbol image for given symbol name.
///    This function never set symbol image to image view component
///    Use "setSymbol(_ name:,_ font:)" or intilize with "init(_ name:,_ font:))".
    func symbol(for name: AppSymbolNameType,_ font: UIFont, scale symbolScale: CustomSymbolScale = .medium) -> UIImage? {
        if #available(iOS 13.0, *){
            let symbolConfig = Self.symbolWithConfiguration(for: name, font, scale: symbolScale.originalImageScale)
            self.preferredSymbolConfiguration = symbolConfig.config
            return symbolConfig.symbol
            
        }else{
            return UIImage.init(named: name.rawValue)?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    ///Set symbol for given symbol name
    func setSymbol(_ name:AppSymbolNameType,_ font:UIFont = .systemFont(ofSize: 22), scale symbolScale: CustomSymbolScale = .medium){
        self.image = symbol(for: name, font, scale: symbolScale)
    }
}

extension UIImageView : AppSymbol {}

extension UIImageView {
    public convenience init(_ name: AppSymbolNameType,_ font: UIFont = .systemFont(ofSize: 22), scale symbolScale: CustomSymbolScale = .medium) {
        self.init()
        setSymbol(name, font, scale: symbolScale)
    }

}
