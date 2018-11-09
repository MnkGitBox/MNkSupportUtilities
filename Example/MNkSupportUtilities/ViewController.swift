//
//  ViewController.swift
//  MNkSupportUtilities
//
//  Created by m.nadeeshan@yahoo.co.uk on 11/02/2018.
//  Copyright (c) 2018 m.nadeeshan@yahoo.co.uk. All rights reserved.
//

import UIKit
import MNkSupportUtilities

class ViewController:MNkBaseVCWithParameter<Model>{
    
    override func fetchData() {}
    override func insertAndLayoutSubviews() {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = nil
        
        view.activeShadow()
    }
}

struct Model{
    
}

class SampleTVCell: MNkBaseTVCell<Model>{
    
}

class SampleCVCell: MNkBaseCVCell<Model>{
    
    override func updateUI() {}
   
}

class TableviewController: MNkBaseTableVC<Model,SampleTVCell>{
    
    override func fetchData() {
        
    }
    
    
}

class TextView: MNkTextViewNoPadding{
    
}
