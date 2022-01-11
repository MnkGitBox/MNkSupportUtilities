//
//  AppSymbol_comp.swift
//  MNkSupportUtilities_Example
//
//  Created by Malith Kamburapola on 2022-01-11.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import MNkSupportUtilities

class AppSymbol_Sample: MNkViewController {
    
    private var shareButton: UIButton = {
        let btn = UIButton.init(with: .squareAndArrowUp, to: .systemFont(ofSize: 17, weight: .medium), for: .normal, scale: .medium)
        btn.frame = .init(origin: .init(x: 50, y: 100),
                          size: .init(width: 100, height: 45))
        btn.setTitle("Share", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        btn.tintColor = .systemBlue
        btn.backgroundColor = .black.withAlphaComponent(0.12)
        btn.layer.cornerRadius = 3
        btn.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 8)
        return btn
    }()
    
    private var lockButton: UIButton = {
        let btn = UIButton.init(with: .lockOpenLine, to: .systemFont(ofSize: 17, weight: .medium), for: .normal, scale: .medium)
        btn.frame = .init(origin: .init(x: 50, y: 200),
                          size: .init(width: 120, height: 45))
        btn.setTitle("Unlocked", for: .normal)
        btn.setTitleColor(.systemGreen, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        btn.tintColor = .systemGreen
        btn.backgroundColor = .black.withAlphaComponent(0.08)
        btn.layer.cornerRadius = 3
        btn.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 8)
        return btn
    }()
    
    override func insertAndLayoutSubviews() {
        view.addSubview(shareButton)
        view.addSubview(lockButton)
    }
    
    override func config() {
        view.backgroundColor = .white
    }
}


extension AppSymbolNames {
    static var squareAndArrowUp: AppSymbolNameType { .init(rawValue: "square.and.arrow.up") }
    
    static var lockOpenLine: AppSymbolNameType { .init(rawValue: "lock.open.line") }
}
