//
//  Helper+Protocol.swift
//  MNkSupportUtilities
//
//  Created by Malith Nadeeshan on 7/23/20.
//

import UIKit

//MARK: - UINavigation bar
//01
public protocol NavigationBarTransparentCompitable {
    var isSetHiddenNavigationBarBackground: Bool { get }
}

public extension NavigationBarTransparentCompitable where Self: UIViewController {
    var isSetHiddenNavigationBarBackground: Bool {
        self.navigationController?.navigationBar.backgroundImage(for: .default) != nil
    }
    
    func setNavigationBarBackground( hidden isHidden: Bool) {
        let bgImage = isHidden ? UIImage() : nil
        let shadowImage = isHidden ? UIImage() : nil
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(bgImage, for: .default)
        self.navigationController?.navigationBar.shadowImage = shadowImage
    }
}

//02
public protocol NavBarBackButtonAccesable: AnyObject {
    
    var navigationBackButton: UIButton! { get set }
    
    var backTitle: String { get }
    
    func configureNavigationCustomBackButton()
    
}

public extension NavBarBackButtonAccesable where Self : UIViewController {
    
    private var backSymbolImage: UIImage? { UIImage.init(named: "nav.back") }
    
    var backTitle: String { "   " }
    
    ///Navigation bar default back action overide
    func configureNavigationCustomBackButton() {
        self.navigationItem.hidesBackButton = true

        navigationBackButton = UIButton()
        navigationBackButton.setImage(backSymbolImage?.withRenderingMode(.alwaysTemplate), for: .normal)
        navigationBackButton.setTitle(backTitle, for: .normal)
        navigationBackButton.setTitleColor(UINavigationBar.appearance().tintColor, for: .normal)
        navigationBackButton.setTitleColor(UIColor.gray, for: .disabled)
        navigationBackButton.titleLabel?.font = .systemFont(ofSize: 17)
        navigationBackButton.titleEdgeInsets = .init(top: 0, left: -12, bottom: 0, right: 0)
        navigationBackButton.imageEdgeInsets = .init(top: 0, left: -18, bottom: 0, right: 0)
        navigationBackButton.titleLabel?.lineBreakMode = .byTruncatingTail
        navigationBackButton.imageView?.contentMode = .scaleAspectFit

        let buttonContainerView = UIView()
        buttonContainerView.addSubview(navigationBackButton)
        navigationBackButton.activateLayouts([.leading: 0, .top: 0, .bottom: 0, .traling: 0, .height: 27])
        NSLayoutConstraint.activate([navigationBackButton.widthAnchor.constraint(lessThanOrEqualToConstant: self.view.bounds.size.width*0.45)])

        let backBarButtonItem = UIBarButtonItem.init(customView: buttonContainerView)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
    }
}
