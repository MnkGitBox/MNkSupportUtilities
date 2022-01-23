//
//  AppSymbol+UIButton.swift
//  MNkSupportUtilities
//
//  Created by Malith Nadeeshan on 7/23/20.
//

import UIKit

public extension AppSymbol where Self: UIButton {
    
    ///    Will return symbol image for given symbol name.
    ///    This function never set symbol image to image view component
    ///    Use setSymbol(_ symbolName:,to font:,for state:)
    func symbol(for name: AppSymbolNameType,_ font: UIFont, scale symbolScale: CustomSymbolScale = .medium) -> UIImage? {
        if #available(iOS 13.0, *) {
            let symbolConfig = Self.symbolWithConfiguration(for: name, font, scale: symbolScale.originalImageScale)
            self.setPreferredSymbolConfiguration(symbolConfig.config, forImageIn: .normal)
            return symbolConfig.symbol
            
        } else {
            return UIImage.init(named: name.rawValue)?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    ///    Sets the symbol image to use in specific state
    func setSymbol(_ symbolName:AppSymbolNameType,
                   to font: UIFont = .systemFont(ofSize: 22),
                   for state: UIControl.State = .normal,
                   scale symbolScale: CustomSymbolScale = .medium) {
        
        let symbol = self.symbol(for: symbolName, font, scale: symbolScale)
        self.setImage(symbol, for: state)
    }
}

extension UIButton : AppSymbol {}

extension UIButton {
    public convenience init(with symbolName: AppSymbolNameType, to font:UIFont = .systemFont(ofSize: 22),
                     for state: UIControl.State = .normal, scale symbolScale: CustomSymbolScale = .medium) {
        self.init()
        setSymbol(symbolName, to: font, for: state, scale: symbolScale)
    }
}
