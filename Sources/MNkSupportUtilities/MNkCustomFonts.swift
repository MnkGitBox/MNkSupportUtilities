//
//  MNkCustomFonts.swift
//  MNkSupportUtilities
//
//  Created by Malith Kamburapola on 2021-10-05.
//

import UIKit

public class MNkCustomFonts: NSObject {
    //Static declaration
    public static var shared: MNkCustomFonts = MNkCustomFonts()
    private override init() {
        fontScaleSize = CustomFontSizeScale.scaleForDeviceScreen
        print("log_ :", fontScaleSize)
    }
    
    //private / internal
    private var customFontsWithDynamicStyles = [UIFont.TextStyle : UIFont]()
    
    private var systemFontsWithCustomDynamicStyles = [UIFont.TextStyle : UIFont]()
    
    private var customFontsStyles = [CustomFontTextStyle : UIFont]()
    
    private let fontScaleSize: CustomFontSizeScale
    
    internal func customFontCustomDynamicScale(for style: UIFont.TextStyle) -> UIFont {
        guard let font = customFontsWithDynamicStyles[style] else {
            fatalError("Please set font for style in first place before access. <<'\(style.name)' font is missing>>")
        }

        let scaledFont = UIFontMetrics(forTextStyle: style).scaledFont(for: font)

        return scaledFont
    }
    
    internal func systemFontCustomDynamicScales(for style: UIFont.TextStyle) -> UIFont {
        guard let font = systemFontsWithCustomDynamicStyles[style] else {
            fatalError("Please set font for style in first place before access. <<'\(style.name)' font is missing>>")
        }

        let scaledFont = UIFontMetrics(forTextStyle: style).scaledFont(for: font)
        
        return scaledFont
    }
    
    internal func customFont(for style: CustomFontTextStyle) -> UIFont {
        guard let font = customFontsStyles[style] else {
            fatalError("Please set font for style in first place before access. <<'\(style.name)' font is missing>>")
        }

        return font
    }
    
    
    //public
    
    ///Set custom fonts with dynamic style to support font scale changes in device
    public func setDynamicScale(_ fontStyles: [UIFont.TextStyle : UIFont], deviceBaseScale supportDeviceBaseScale: Bool = false) {
        
        var styleDic = fontStyles
        
        if supportDeviceBaseScale {
            for (key, value) in styleDic {
                styleDic[key] = value.withSize(value.pointSize + fontScaleSize.resizingPoint)
            }
        }
        
        customFontsWithDynamicStyles = styleDic
    }
    
    public func setCustomDynamicScaleForSystemFont(_ fontStyles: [UIFont.TextStyle : UIFont], deviceBaseScale supportDeviceBaseScale: Bool = false) {
        
        var styleDic = fontStyles
        
        if supportDeviceBaseScale {
            for (key, value) in styleDic {
                styleDic[key] = value.withSize(value.pointSize + fontScaleSize.resizingPoint)
            }
        }
        
        systemFontsWithCustomDynamicStyles = styleDic
    }
    
    public func setCustomStyles(_ fontStyles: [CustomFontTextStyle : UIFont], deviceBaseScale supportDeviceBaseScale: Bool = false) {
        var styleDic = fontStyles
        
        if supportDeviceBaseScale {
            for (key, value) in styleDic {
                styleDic[key] = value.withSize(value.pointSize + fontScaleSize.resizingPoint)
            }
        }
        customFontsStyles = styleDic
    }
    
}

//MARK: - EXTENSION TO UIFONT
public extension UIFont {
    class func customFont(forTextStyle style: UIFont.TextStyle) -> UIFont {
        return MNkCustomFonts.shared.customFontCustomDynamicScale(for: style)
    }
    
    class func customFont(forFontTextStyle style: CustomFontTextStyle) -> UIFont {
        return MNkCustomFonts.shared.customFont(for: style)
    }
    
    class func systemFontCustomDynamicScale(forTextStyle style:  UIFont.TextStyle) -> UIFont {
        return MNkCustomFonts.shared.systemFontCustomDynamicScales(for: style)
    }
}

//MARK: - EXTENSION TO UIFONT.TEXTSTYLE
public extension UIFont.TextStyle {
    init(_ name: String) {
        switch name {
        case "largeTitle":
            self = .largeTitle
            
        case "caption2":
            self = .caption2
            
        case "caption1":
            self = .caption1
            
        case "footnote":
            self = .footnote
            
        case "callout":
            self = .callout
            
        case "body":
            self = .body
            
        case "subheadline":
            self = .subheadline
            
        case "headline":
            self = .headline
            
        case "title1":
            self = .title1
            
        case "title2":
            self = .title2
            
        case "title3":
            self = .title3
            
        default:
            self = .body
        }
    }
    
    var name: String {
        switch self {
        case .largeTitle:
            return "largeTitle"
            
        case .caption2:
            return "caption2"
            
        case .caption1:
            return "caption1"
            
        case .footnote:
            return "footnote"
            
        case .callout:
            return "callout"
            
        case .body:
            return "body"
            
        case .subheadline:
            return "subheadline"
            
        case .headline:
            return "headline"
            
        case .title1:
            return "title1"
            
        case .title2:
            return "title2"
            
        case .title3:
            return "title3"
            
        default:
            return "none"
        }
    }
}

