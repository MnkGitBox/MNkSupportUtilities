//
//  MNkCustomFonts.swift
//  MNkSupportUtilities
//
//  Created by Malith Kamburapola on 2021-10-05.
//

import Foundation

public class MNkCustomFonts: NSObject {
    //Static declaration
    public static var shared: MNkCustomFonts = MNkCustomFonts()
    private override init() {
        fontScaleSize = CustomFontSizeScale.scaleForDeviceScreen
        print("log_ :", fontScaleSize)
    }
    
    //private / internal
    private var customFontsWithDynamicStyles = [UIFont.TextStyle : UIFont]()
    
    private var customFontsStyles = [CustomFontTextStyle : UIFont]()
    
    private let fontScaleSize: CustomFontSizeScale
    
    internal func deviceScaledSizedDynamicFont(for style: UIFont.TextStyle, _ supportDeviceBaseScale: Bool) -> UIFont {
        guard let font = customFontsWithDynamicStyles[style] else {
            fatalError("Please set font for style in first place before access. <<'\(style.name)' font is missing>>")
        }

        let metrics = UIFontMetrics(forTextStyle: style)
        var scaledFont = metrics.scaledFont(for: font)
        
        if supportDeviceBaseScale {
            scaledFont = scaledFont.withSize(scaledFont.pointSize +  fontScaleSize.resizingPoint)
        }

        return scaledFont
    }
    
    internal func customFont(for style: CustomFontTextStyle, _ supportDeviceBaseScale: Bool) -> UIFont {
        guard var font = customFontsStyles[style] else {
            fatalError("Please set font for style in first place before access. <<'\(style.name)' font is missing>>")
        }

        if supportDeviceBaseScale {
            font = font.withSize(font.pointSize +  fontScaleSize.resizingPoint)
        }

        return font
    }
    
    
    //public
    
    ///Set custom fonts with dynamic style to support font scale changes in device
    public func setDynamicStyles(_ fontStyles: [UIFont.TextStyle : UIFont]) {
        customFontsWithDynamicStyles = fontStyles
    }
    
    public func setCustomStyles(_ fontStyles: [CustomFontTextStyle : UIFont]) {
        customFontsStyles = fontStyles
    }
    
}

//MARK: - EXTENSION TO UIFONT
public extension UIFont {
    class func customFont(forTextStyle style: UIFont.TextStyle, deviceBaseScale supportDeviceBaseScale: Bool = true) -> UIFont {
        return MNkCustomFonts.shared.deviceScaledSizedDynamicFont(for: style, supportDeviceBaseScale)
    }
    
    class func customFont(forTextStyle style: CustomFontTextStyle, deviceBaseScale supportDeviceBaseScale: Bool = true) -> UIFont {
        return MNkCustomFonts.shared.customFont(for: style, supportDeviceBaseScale)
    }
}

//MARK: - EXTENSION TO UIFONT.TEXTSTYLE
public extension UIFont.TextStyle {
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

