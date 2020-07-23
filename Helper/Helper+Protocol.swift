//
//  Helper+Protocol.swift
//  MNkSupportUtilities
//
//  Created by Malith Nadeeshan on 7/23/20.
//

import UIKit

//MARK: - UINavigation bar
//01
public protocol NavigationBarTransparentCompitable {}

extension NavigationBarTransparentCompitable where Self: UIViewController {
    public func setNavigationBarBackground( hidden isHidden: Bool) {
        let bgImage = isHidden ? UIImage() : nil
        let shadowImage = isHidden ? UIImage() : nil
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(bgImage, for: .default)
        self.navigationController?.navigationBar.shadowImage = shadowImage
    }
}

//02
public protocol NavBarBackButtonAccesable {
    
    var backButtonItem: UIButton  { get set }
    
    func navigationBackActionConfiguration()
    
}

extension NavBarBackButtonAccesable where Self : UIViewController {
    
    public var backSymbolImage: UIImage? { UIImage.init(named: "nav.back") }
    
    ///Navigation bar default back action overide
    public func navigationBackActionConfiguration() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationItem.hidesBackButton = true

        let buttonContainerView = UIView()
        buttonContainerView.addSubview(backButtonItem)
        backButtonItem.activateLayouts([.leading: -7, .top:0, .bottom: 0, .traling: 0])
        let backBarButtonItem = UIBarButtonItem.init(customView: buttonContainerView)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
}
