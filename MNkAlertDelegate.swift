//
//  MNkAlertDelegate.swift
//  MNkSupportUtilities
//
//  Created by Malith Kamburapola on 2022-01-11.
//

import Foundation

@objc public protocol MNkAlertDelegate: AnyObject {
    @objc optional func userPerformAlertAction(_ action: MNkAlertAction, aditional data: Any?)
}
