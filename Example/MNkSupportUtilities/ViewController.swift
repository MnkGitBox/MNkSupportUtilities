//
//  ViewController.swift
//  MNkSupportUtilities
//
//  Created by m.nadeeshan@yahoo.co.uk on 11/02/2018.
//  Copyright (c) 2018 m.nadeeshan@yahoo.co.uk. All rights reserved.
//

import UIKit
import MNkSupportUtilities

class ViewController:MNkCollectionVC_Parameter_CellType<Test,Cell>{
    
    override func fetchData() {
        data = [Test(),Test(),Test(),Test(),Test(),Test(),Test(),Test(),Test(),Test(),Test(),Test()]
    }
    override func config() {
        super.config()
        print(safeAreaEdgeInsets)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.bounds.size.width / 2,
                           height: 80)
    }
}


class Cell:MNkCVCell_Parameter<Test>{
    override func config() {
        backgroundColor = .red
//        let btn = UIButton.init(with: .menu)
    }
}

struct Test{}

extension AppSymbolNames {
    static var menu: AppSymbolNameType {
        return .init(rawValue: "Menu")
    }
}
