//
//  MNkTextField.swift
//  MNkSupportUtilities
//
//  Created by Malith Nadeeshan on 3/23/19.
//

import Foundation

open class MNkTextField: UITextField {
    
    public var errorBorder: Edge = .bottom
    
    public var errBorderView:UIView? {
        return borderViews.filter{return $0.tag == errorBorder.rawValue}.first
    }
    
    public enum Edge:Int{
        case top = 0
        case bottom = 1
        case left = 2
        case right = 3
    }
    
    public var borders:[Edge] = []{
        didSet{
            removeBorders()
            insertBorders()
        }
    }
    
    public var borderColor: UIColor = .red {
        didSet{
            changeBorderColors()
        }
    }
    
    private var borderViews: [UIView] = []
    
    private let _errorLabel = UILabel().chain.font(.systemFont(ofSize: 16.5)).textColor(.red).component
    
    private func insertBorders(){
        for edge in borders{
            insertBorder(to: edge)
        }
    }
    
    private func insertBorder(to edge:Edge){
        let border = UIView()
        border.backgroundColor = borderColor
        border.tag = edge.rawValue
        border.translatesAutoresizingMaskIntoConstraints = false
        addSubview(border)
        borderViews.append(border)
        
        switch edge{
        case .bottom:
            NSLayoutConstraint.activate([border.heightAnchor.constraint(equalToConstant: 0.5),
                                         border.leadingAnchor.constraint(equalTo: leadingAnchor),
                                         border.trailingAnchor.constraint(equalTo: trailingAnchor),
                                         border.bottomAnchor.constraint(equalTo: bottomAnchor)])
        case .top:
            NSLayoutConstraint.activate([border.heightAnchor.constraint(equalToConstant: 0.5),
                                         border.leadingAnchor.constraint(equalTo: leadingAnchor),
                                         border.trailingAnchor.constraint(equalTo: trailingAnchor),
                                         border.topAnchor.constraint(equalTo: topAnchor)])
        case .left:
            NSLayoutConstraint.activate([border.widthAnchor.constraint(equalToConstant: 0.5),
                                         border.leadingAnchor.constraint(equalTo: leadingAnchor),
                                         border.topAnchor.constraint(equalTo: topAnchor),
                                         border.bottomAnchor.constraint(equalTo: bottomAnchor)])
        case .right:
            NSLayoutConstraint.activate([border.widthAnchor.constraint(equalToConstant: 0.5),
                                         border.trailingAnchor.constraint(equalTo: trailingAnchor),
                                         border.topAnchor.constraint(equalTo: topAnchor),
                                         border.bottomAnchor.constraint(equalTo: bottomAnchor)])
        }
    }
    
    private func removeBorders(){
        for border in borderViews{
            border.removeFromSuperview()
        }
    }
    
    private func changeBorderColors(){
        for border in borderViews{
            border.backgroundColor = borderColor
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        insertSubViews()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func insertSubViews() {
        addSubview(_errorLabel)
        _errorLabel.activateLayouts([.traling: -2, .centerY: 0])
    }
}

/*..........................................................
 MARK:- Validatable textview protocol implementation
 ..........................................................*/
extension MNkTextField: MNkValidatableTextView {
    
    public var textView: UIView { self }
    
    public var errorBorderView: UIView? { errBorderView }
    
    public var errorLabel: UILabel? { _errorLabel }
    
}
