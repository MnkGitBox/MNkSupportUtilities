//
//  CustomFontSizeScale.swift
//  MNkSupportUtilities
//
//  Created by Malith Kamburapola on 2021-10-05.
//

import Foundation

enum CustomFontSizeScale: Int {
    case small = -1
    case regular = 0
    case medium = 1
    case xMedium = 2
    case large = 3
    case xLarge = 4
    case xxLarge = 5
    case xxxLarge = 6
    //320 - small
    //375 - regular
    //414 - medium
    //476 - xMedium
    //768 - large
    //1024 - xLarge
    //1112 - xxLarge
    //xxxLarge
    
    
    var resizingPoint: CGFloat {
        switch self {
        case .small:
            return -2
            
        case .regular:
            return 0
            
        case .medium:
            return 1
            
        case .xMedium:
            return 2
            
        case .large:
            return 3
            
        case .xLarge:
            return 4
            
        case .xxLarge:
            return 5
            
        case .xxxLarge:
            return 6
        }
    }
    
    static var scaleForDeviceScreen: CustomFontSizeScale {
        let deviceWidth = CGFloat.minimum(UIScreen.main.bounds.size.width, UIScreen.main.bounds.height)
        print("log_ :", deviceWidth)
        switch deviceWidth {
        case let width where (width == 320 || width < 320):
            return .small
            
        case let width where (width <= 375 && width > 320):
            return .regular
            
        case let width where (width <= 414 && width > 375):
            return .medium
            
        case let width where (width <= 476 && width > 414):
            return .xMedium
            
        case let width where (width <= 768 && width > 476):
            return .large
            
        case let width where (width <= 1024 && width > 768):
            return .xLarge
            
        case let width where (width <= 1112 && width > 1024):
            return .xxLarge
            
        case let width where width > 1112:
            return .xxxLarge
            
        default:
            return .regular
        }
    }
    
}
