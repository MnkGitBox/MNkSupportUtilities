//
//  CustomFontTextStyle.swift
//  MNkSupportUtilities
//
//  Created by Malith Kamburapola on 2021-10-05.
//

import Foundation

public enum CustomFontTextStyle: Int {
    case largeTitle = 0
    case title1 = 1
    case title2 = 2
    case title3 = 3
    case headline = 4
    case subheadline = 5
    case body = 6
    case callout = 7
    case footnote = 8
    case caption1 = 9
    case caption2 = 10
    
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
        }
    }
}
