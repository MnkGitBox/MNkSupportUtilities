//
//  BlurButton.swift
//  MNkSupportUtilities
//
//  Created by Malith Nadeeshan on 12/22/20.
//

import UIKit

open class BlurButton: MNkView {
    
    public let button: UIButton
    
    private let blurEffect: UIBlurEffect
    
    open override func insertAndLayoutSubviews() {
        let blurView = UIVisualEffectView.init(effect: blurEffect)
        addSubview(blurView)
        blurView.activateLayouts()
        
        addSubview(button)
        button.activateLayouts()
    }
    
    open override func config() {
        backgroundColor = .clear 
    }
    
    public init(_ button: UIButton, _ effect: UIBlurEffect.Style = .light) {
        self.button = button
        self.blurEffect = .init(style: effect)
        super.init(frame: .zero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
