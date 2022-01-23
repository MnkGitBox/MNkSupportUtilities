//
//  MNkAlertAction.swift
//  MNkSupportUtilities
//
//  Created by Malith Kamburapola on 2022-01-11.
//

import Foundation

@objc public enum MNkAlertAction: Int {
    ///Aggreed state. Ussually from right action button
    case rightClick
    ///Dis-Aggreed state. Ussually from left action button
    case leftClick
    ///State is not from accept or Cancell
    case none
    
    public init(_ rawValue: Int) {
        switch rawValue {
        case 0:
            self = .rightClick
            
        case 1:
            self = .leftClick
            
        default:
            self = .none
        }
    }
}
