//
//  MNkAlertView.swift
//
//  Created by Malith Nadeeshan on 6/13/18.
//  Copyright © 2018 Malith Nadeeshan. All rights reserved.
//

import UIKit

open class MNkAlertView: UIView {

    ///You can catch action in delegate manner.
    public weak var delegate: MNkAlertDelegate?
    
    ///You can catch any button action by assign a function type.
    public var action: ((_ action: MNkAlertAction, _ data: Any?) -> Void)?
    
    ///Type of the alert action you can set here. *(ex: .single :- only one action button display)*
    public var type: MNkAlertActionType  = .single
    
    ///Content aligment
    public var aligment: MNkAlertViewContentAligment = .center
    
    
    ///Title label of the alert
    public var titleLabel:UILabel!
    
    ///Message  label of the alert
    public var messageLabel:UILabel!
    
    ///Left side action button label of the alert
    public var leftActionButton:UIButton!
    
    ///Right side action button label of the alert
    public var rightActionButton:UIButton!
    
    ///Horizontal stack view that contains the action buttons
    public var buttonStackview:UIStackView!
    
    ///Alert element container view
    public var alertContainer:UIView!
    
    ///Vertical stack view that contains the all main alert element. (ex: title label, message label, and button stack view)
    public var mainStackView:UIStackView!
    
    private var buttonActionClouser: ((MNkAlertAction)->Void)?
    
    private func setUpdatedConfig() {
        leftActionButton.isHidden = type == .single ? true : false
    }
    
    
    //MARK: - Actions
    /**
    - Show alert view with heading and alert message.
    - You can choose what type of your alert need to be by seting type. Single and multilple, Single only show ok button and action be default hide
    By changing properties you can change button title -> text, color, background color like things.
    - And using action clouser, you can catch any action perform by user and give action you want.
     */
    open func show(in targetView: UIView, perform buttonAction: ((MNkAlertAction)->Void)? = nil){
        targetView.addSubview(self)
        self.frame = targetView.bounds
        
        setUpdatedConfig()
        
        animate(show: true)
        
        buttonActionClouser = buttonAction
    }
    
    public func dismiss(_ completed: @escaping ()->Void) {
        animate(show: false, completed)
    }
    

    //Button Actions
    
    @objc public func didTapRightActionButton() {
        self.dismiss { [weak self] in
            if let `buttonActionClouser` = self?.buttonActionClouser {
                buttonActionClouser(.rightClick)
            }
            
            if let `delegate` = self?.delegate {
                delegate.userPerformAlertAction?(.rightClick, aditional: nil)
            }
        }
    }
    
    @objc public func didTapLeftActionButton() {
        self.dismiss { [weak self] in
            if let `buttonActionClouser` = self?.buttonActionClouser {
                buttonActionClouser(.leftClick)
            }
            
            if let `delegate` = self?.delegate {
                delegate.userPerformAlertAction?(.leftClick, aditional: nil)
            }
        }
    }
    
    
    //MARK: - Init the view
    private func loadViews() {
        createViews()
        insertAndLayoutSubviews()
        config()
    }
    
    open func createViews() {
        _createViews()
    }
    
    open func insertAndLayoutSubviews() {
        _insertAndLayoutSubviews()
    }
    
    open func config() {
        _config()
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadViews()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
}


//MARK: - ANIMATION RELATIVE CODE
extension MNkAlertView {
    private func animate(show isShowing: Bool, _ completed: (()->Void)? = nil) {
        if isShowing {
            self.alpha = 0
            self.alertContainer.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        
        let duration: Double = isShowing ? 0.2 : 0.15
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
            
            self.alpha = isShowing ? 1 : 0
            self.alertContainer.transform = isShowing ? .identity : CGAffineTransform(scaleX: 1.1, y: 1.1)
            
        }) {  isCompleted in
            guard isCompleted, !isShowing else { return }
            self.removeFromSuperview()
            completed?()
        }
    }
}
