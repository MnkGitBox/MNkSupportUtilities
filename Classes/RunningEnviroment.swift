//
//  RunningEnviroment.swift
//  MNkSupportUtilities
//
//  Created by Malith Kamburapola on 2021-06-10.
//

import Foundation

public enum Environment {
    case production
    case testFlight
    case debug
    
    public static var current: Self {
        #if DEBUG
        return .debug
        
        #else
        guard let receiptUrl = Bundle.main.appStoreReceiptURL,
              (receiptUrl.lastPathComponent == "sandboxReceipt" ||
                Bundle.main.path(forResource: "embedded", ofType: "mobileprovision") != nil) else {
            
            return .production
        }
        
        return .testFlight
        #endif
    }
    
}
