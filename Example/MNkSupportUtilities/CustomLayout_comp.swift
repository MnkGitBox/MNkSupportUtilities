//
//  CustomLayout_comp.swift
//  MNkSupportUtilities_Example
//
//  Created by Malith Kamburapola on 2022-01-13.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import MNkSupportUtilities

class CustomLayout_Sample: MNkViewController {
    private var redView: UIView!
    private var blueView: UIView!
    private var orangeView: UIView!
    
    
    override func createViews() {
        redView = UIView()
        redView.backgroundColor = .red
    }
    
    override func insertAndLayoutSubviews() {
        view.addSubview(redView)
        view.addSubview(blueView)
        view.addSubview(orangeView)
        
//        view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([redView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
//                                                                     constant: 50),
//                                     redView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
//                                                                       constant: -50),
//                                     redView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
//                                                                  constant: 40),
//                                     redView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
//                                                                     constant: -20)])
        
        redView.activateLayouts([.leading: 50, .traling: -50, .top: 40, .bottom: -20], layoutToSafeArea: true)
        
        
        
        blueView.activateLayouts(to: [redView : [.leading: 0, .traling: 0, .height: 50],
                                         view : [.centerY: 0]], layoutToSafeArea: true)
    }
}
