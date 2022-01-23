//
//  AppSymbolNameType.swift
//  MNkSupportUtilities
//
//  Created by Malith Nadeeshan on 7/23/20.
//

import Foundation

public struct AppSymbolNameType: RawRepresentable, Equatable, Hashable, Comparable  {
    
    public var rawValue: String
    
    public var hashValue: Int {
        return rawValue.hashValue
    }
    
    public static func < (lhs: AppSymbolNameType, rhs: AppSymbolNameType) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
}

public protocol AppSymbolNames {}
extension AppSymbolNameType: AppSymbolNames {}
