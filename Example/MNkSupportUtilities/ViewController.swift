//
//  ViewController.swift
//  MNkSupportUtilities
//
//  Created by m.nadeeshan@yahoo.co.uk on 11/02/2018.
//  Copyright (c) 2018 m.nadeeshan@yahoo.co.uk. All rights reserved.
//

import UIKit
import MNkSupportUtilities

class ViewController:MNkViewController{
    
    var textField:MNkTextFieldWithError!
    
    override func createViews() {
        textField = MNkTextFieldWithError()
        textField.textField.borders = [.bottom]
        textField.textField.borderColor = .green
    }
    
    override func insertAndLayoutSubviews() {
        view.addSubview(textField)
        textField.activateLayouts(to: self.view, [.centerY:0,.centerX:0,.width:200])
    }
    
    override func config() {
        textField.errorLabel.text = "This is error...!"
    }
}
