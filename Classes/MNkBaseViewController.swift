//
//  MNkBaseViewController.swift
//  FBSnapshotTestCase
//
//  Created by MNk_Dev on 2/11/18.
//

import UIKit

open class MNkBaseVCWithParameter<T>: MNkBasicViewController {
    
    public var data:T?{didSet{reloadData()}}

}






