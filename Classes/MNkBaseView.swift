//
//  MNkBaseView.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 9/11/18.
//
import UIKit
open class MNkBaseView<T>:MNkView{
    public var data:T!{didSet{updateUIWithNewData()}}
}
