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
public protocol NavBarBackButtonAccesable: class {
    
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

        navigationBackButton = UIButton().chain
            .setImage(backSymbolImage)
            .title(backTitle)
            .font(.systemFont(ofSize: 15))
            .lineBreakingMode(.byTruncatingTail)
            .component

        let buttonContainerView = UIView()
        buttonContainerView.addSubview(navigationBackButton)
        navigationBackButton.activateLayouts([.leading: -7, .top: 2, .bottom: -2, .traling: 0])
        NSLayoutConstraint.activate([navigationBackButton.widthAnchor.constraint(lessThanOrEqualToConstant: self.view.bounds.size.width*0.4)])

        let backBarButtonItem = UIBarButtonItem.init(customView: buttonContainerView)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
    }
}
