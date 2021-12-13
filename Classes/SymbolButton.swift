//
//  SymbolButton.swift
//  MNkSupportUtilities
//
//  Created by Malith Kamburapola on 2021-10-09.
//

import UIKit

public protocol SymbolButtonDelegate: AnyObject {
    func didTapSymbolButton(_ button: SymbolButton)
}

@IBDesignable
open class SymbolButton: MNkView {
    
    public weak var delegate: SymbolButtonDelegate? {
        didSet {
            if delegate == nil {
                gesture.removeTarget(self, action: #selector(didTapDelegateTarget))
                
            } else {
                gesture.addTarget(self, action: #selector(didTapDelegateTarget))
            }
        }
    }
    
    ///Set Any data you want to retrive later.
    public var data: Any?
    
    private var symbolName: AppSymbolNameType = .init(rawValue: "star")
    private var symbolScale: CustomSymbolScale = .medium
    private var textStyle: UIFont.TextStyle = .body
    
    @IBInspectable public var symolNameString: String = "star" {
        didSet {
            symbolName = .init(rawValue: symolNameString)
        }
    }
    
    @IBInspectable public var symbolScaleValue: Int {
        get {
            return symbolScale.rawValue
        }
        set {
            self.symbolScale = CustomSymbolScale.init(rawValue: newValue)!
        }
    }
    
    @IBInspectable public var textStyleValues: String {
        get {
            return textStyle.rawValue
        }
        set {
            self.textStyle = .init(newValue)
        }
    }
    
    @IBInspectable public var padding: CGFloat = 20
    
    public lazy var color: UIColor = imageView.tintColor {
        didSet {
            imageView.tintColor = color
        }
    }
    
    public init(name symbolName: AppSymbolNameType, padding: CGFloat, style textStyle: UIFont.TextStyle = .title2, scale symbolScale: CustomSymbolScale = .medium) {
        self.padding = padding
        self.symbolName = symbolName
        self.textStyle = textStyle
        self.symbolScale = symbolScale
        super.init(frame: .zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private var widthContraint: NSLayoutConstraint?
    private var heightContraint: NSLayoutConstraint?
    
    private var imageView: UIImageView!
    
    private let gesture = UITapGestureRecognizer()
    
    open override func createViews() {
        imageView = UIImageView.init(symbolName, .preferredFont(forTextStyle: textStyle)).chain
            .contentMode(.scaleAspectFit).adjustsImageSizeForAccessibilityContentSizeCategory(true).component
    }
    
    open override func insertAndLayoutSubviews() {
        addSubview(imageView)
        imageView.activateLayouts([.centerX: 0, .centerY: 0])
        
        widthContraint = self.widthAnchor.constraint(equalToConstant: 50)
        heightContraint = self.heightAnchor.constraint(equalToConstant: 50)
        widthContraint?.isActive = true
        heightContraint?.isActive = true
        
        if #available(iOS 13, *) {} else {
            imageView.activateLayouts(equalConstant: padding/2)
        }
        
        addGestureRecognizer(gesture)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        layoutSuperView()
    }
    
    private func layoutSuperView() {
        let fontSize = UIFont.preferredFont(forTextStyle: textStyle).pointSize
        let size = UIFontMetrics.init(forTextStyle: textStyle).scaledValue(for: fontSize) + padding
        widthContraint?.constant = size
        heightContraint?.constant = size
        self.layer.cornerRadius = size/2
        
        print("log_ maxButtonSize \(symbolName.rawValue): ", size, UIFontMetrics.init(forTextStyle: textStyle).scaledValue(for: padding))
    }
    
    //This will call when delegate set
    @objc private func didTapDelegateTarget() {
        delegate?.didTapSymbolButton(self)
    }
    
    open override func config() {
        self.isUserInteractionEnabled = true
    }
    
    public func addTarget(_ target: Any, _ action: Selector) {
        gesture.addTarget(target, action: action)
    }
}
