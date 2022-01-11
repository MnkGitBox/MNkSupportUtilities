//
//  UIKitChain_comp.swift
//  MNkSupportUtilities_Example
//
//  Created by Malith Kamburapola on 2022-01-11.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import MNkSupportUtilities

class UIKitChain_Sample: MNkViewController {
    private var circleView: UIView!
    
    override func createViews() {
        //With out UIKitChain
//        circleView = UIView()
//        circleView.backgroundColor = .green
//        circleView.layer.cornerRadius = 50
//        circleView.layer.borderColor = UIColor.black.cgColor
//        circleView.layer.borderWidth = 1
//        circleView.clipsToBounds = true
//        circleView.translatesAutoresizingMaskIntoConstraints = false
        
        //With UIKitChain
        circleView = UIView().chain.bgColor(.green).cornerRadius(50).clipToBounds(true).border(.black).activeAutoConstrant(false).component
    }
    
    override func insertAndLayoutSubviews() {
        view.addSubview(circleView)
        NSLayoutConstraint.activate([circleView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     circleView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                                     circleView.heightAnchor.constraint(equalToConstant: 100),
                                     circleView.widthAnchor.constraint(equalTo: circleView.heightAnchor)])
    }
}


//MARK: - ADD MISSING FUNCTIONS OR VARIABLE
extension UIKitChain where Component: UIView {
    @discardableResult
    func roundView() -> Self {
        component.layer.cornerRadius = component.bounds.height/2
        return self
    }
}
