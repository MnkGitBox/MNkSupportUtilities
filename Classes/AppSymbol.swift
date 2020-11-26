//
//  AppSymbol.swift
//  MNkSupportUtilities
//
//  Created by Malith Nadeeshan on 7/23/20.
//

import UIKit

@available(iOS 13.0, *)
typealias SymbolConfiguration = (config: UIImage.SymbolConfiguration, symbol: UIImage?)


public protocol AppSymbol{
    func symbol(for name: AppSymbolNameType, _ font: UIFont) -> UIImage?
}



//MARK:- Helper Func
extension AppSymbol{
    
    static func symbol(for name: AppSymbolNameType) -> UIImage? {
        //Will try to get system symbols or can't, it will return custom symbol with configuration
        guard #available(iOS 13.0, *),
            let systemImage = UIImage.init(systemSymbol: name) else {
                //New iOS device not system symbol
                return UIImage.init(symbol: name)?.withRenderingMode(.alwaysTemplate)
                
        }
        
        return systemImage
    }
    
    
    @available(iOS 13.0, *)
    static func symbolWithConfiguration(for name: AppSymbolNameType,_ font: UIFont) -> SymbolConfiguration {
        let symbolResult = Self.symbol(for: name)
        let config = UIImage.SymbolConfiguration.init(font: font)
        return (config, symbolResult)
    }
    
}


//MARK:- UIImage Convinient Init
// Please don't initialize directly to app symbol name for image
// It Will Provide result but not with symbol configuration
// These init for use AppSymbol protcol to deside to get image with normal(before iOS 13) or new(after iOS 13) symbols.
fileprivate extension UIImage {
    convenience init?(symbol named: AppSymbolNameType) {
        self.init(named: named.rawValue)
    }
    
    @available(iOS 13.0, *)
    convenience init?(systemSymbol named:AppSymbolNameType) {
        self.init(systemName: named.rawValue)
    }
}
