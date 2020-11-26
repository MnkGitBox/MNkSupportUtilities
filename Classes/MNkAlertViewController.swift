//
//  MNkAlertViewController.swift
//  CelebrateSriLanka
//
//  Created by Malith Nadeeshan on 2018-04-03.
//  Copyright © 2018 Azbow. All rights reserved.
//
import Foundation
import UIKit

open class MNkAlertViewController: MNkViewController {
    private var alertView: MNkAlertView!
    
    private var delegate: MNkAlertDelegate?
    private var action: ((_ action: MNkAlertView.MNkAlertAction, _ data: Any?) -> Void)?
    
    public func set(alertView: MNkAlertView) {
        self.alertView = alertView
        self.delegate = alertView.delegate
        self.action = alertView.action
    }
    
    override open func config() {
        view.backgroundColor = .clear
    }
    
    public func showAlert(in target: UIViewController, aditional data: Any?){
        target.present(self, animated: false) { [unowned self] in
            self.alertView.show(in: self.view) { [unowned self] actionType in
                self.dismiss(animated: false) { [unowned self] in
                    self.delegate?.userPerformAlertAction?(actionType, aditional: data)
                    self.action?(actionType, data)
                }
            }
        }
    }
    
    deinit {
        print("deinited MNkAlertViewController")
    }
}

public extension UIViewController{
    func showAlert(of alertVC:MNkAlertViewController, aditional data: Any?){
        alertVC.modalTransitionStyle = .crossDissolve
        alertVC.modalPresentationStyle = .overCurrentContext
        
        alertVC.showAlert(in: self, aditional: data)
    }
}








