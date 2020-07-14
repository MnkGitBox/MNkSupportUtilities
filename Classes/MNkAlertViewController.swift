//
//  MNkAlertViewController.swift
//  CelebrateSriLanka
//
//  Created by Malith Nadeeshan on 2018-04-03.
//  Copyright © 2018 Azbow. All rights reserved.
//
import Foundation
import UIKit

open class MNkAlertViewController:MNkViewController{
    private var alertView = MNkAlertView()
    
    private var delegate: MNkAlertDelegate?
    
    public func set(alertView:MNkAlertView){
        self.alertView = alertView
        delegate = self.alertView.delegate
    }
    
    override open func config() {
        view.backgroundColor = .clear
    }
    
    public func showAlert(in target:UIViewController, aditional data: Any?, _ complete:((MNkAlertView.MNkAlertAction)->Void)? = nil){
        target.present(self, animated: false) { [unowned self] in
            self.alertView.show(in: self.view) { [unowned self] actionType in
                guard let _complete = complete else{
                    self.dismiss(animated: false) { [unowned self] in
                        self.delegate?.userPerformAlertAction?(actionType, aditional: data)
                    }
                    return
                }
                _complete(actionType)
                self.dismiss(animated: false) { [unowned self] in
                    self.delegate?.userPerformAlertAction?(actionType, aditional: data)
                }
            }
        }
    }
    
    deinit {
        print("deinited MNkAlertViewController")
    }
}

public extension UIViewController{
    func showAlert(of alertVC:MNkAlertViewController, aditiona data: Any?, completed:((_ completedAction:MNkAlertView.MNkAlertAction)->())? = nil){
        alertVC.modalTransitionStyle = .crossDissolve
        alertVC.modalPresentationStyle = .overCurrentContext
        
        alertVC.showAlert(in: self, aditional: data, completed)
    }
}








