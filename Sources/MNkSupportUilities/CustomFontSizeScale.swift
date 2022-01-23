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


public struct DeviceSizeClass {
    public enum WidthSize: CGFloat {
        ///320 - small (4' SE . 5s)
        case small = 320
        ///375 - regular (4.7' SE, 6, 6s, 7, 8)
        case regular = 375
        ///390 - medium
        case medium = 390
        ///414 - xMedium
        case large = 414
        ///768 - large
        case xLarge = 428
        ///1024 - xLarge
        case xxLarge = 768
        ///1112 - xxLarge
        case xxxLarge = 1024
        ///>1112
        case extremeLarge = 9999999
    }
    
    public enum HeightSize: CGFloat {
        
        ///568 (4' SE . 5s)
        case xSmall = 568
        ///667 (4.7' SE, 6, 6s, 7, 8)
        case small = 667
        ///736 (6+, 6s+, 7+, 8+)
        case plus = 736
        ///812 (X, Xs, 11Pro, 12Mini)
        case regular = 812
        ///844 (12, 12Pro)
        case medium = 844
        ///896 (Xr, Xs Max, 11, 11Pro Max)
        case large = 896
        ///926 (12Pro Max)
        case xLarge = 926
    }
    
    
    public static var widthClass: DeviceSizeClass.WidthSize {
        let deviceWidth = UIScreen.main.bounds.size.width
        return WidthSize.init(rawValue: deviceWidth) ?? .regular
    }
    
    public static var heightClass: DeviceSizeClass.HeightSize {
        let deviceWidth = UIScreen.main.bounds.size.height
        return HeightSize.init(rawValue: deviceWidth) ?? .regular
    }
    
    public static func heightLessThan(_ size: HeightSize) -> Bool {
        self.heightClass.rawValue < size.rawValue
    }
}
