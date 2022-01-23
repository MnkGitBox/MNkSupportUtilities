//
//  MNkAlertView+LayoutViews.swift
//  MNkSupportUtilities
//
//  Created by Malith Kamburapola on 2022-01-11.
//

import UIKit

extension MNkAlertView {
    internal func _createViews() {
        alertContainer = UIView()
        alertContainer.clipsToBounds = true
        alertContainer.layer.cornerRadius = 9
        alertContainer.backgroundColor = .white
        alertContainer.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel = UILabel()
        titleLabel.text = "heading"
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel = UILabel()
        messageLabel.text = "Message of alert"
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leftActionButton = UIButton()
        leftActionButton.setTitle("Cancel", for: .normal)
        leftActionButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        leftActionButton.setTitleColor(.black.withAlphaComponent(0.6), for: .normal)
        leftActionButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        leftActionButton.backgroundColor = .black.withAlphaComponent(0.05)
        leftActionButton.addTarget(self, action: #selector(didTapLeftActionButton), for: .touchUpInside)
        leftActionButton.translatesAutoresizingMaskIntoConstraints = false
        
        rightActionButton = UIButton()
        rightActionButton.setTitle("OK", for: .normal)
        rightActionButton.setTitleColor(.systemBlue, for: .normal)
        rightActionButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        rightActionButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        rightActionButton.backgroundColor = .black.withAlphaComponent(0.05)
        rightActionButton.addTarget(self, action: #selector(didTapRightActionButton), for: .touchUpInside)
        rightActionButton.translatesAutoresizingMaskIntoConstraints = false
        
        buttonStackview = UIStackView.init(arrangedSubviews: [leftActionButton, rightActionButton])
        buttonStackview.axis = .horizontal
        buttonStackview.distribution = .fillEqually
        buttonStackview.spacing = 1
        buttonStackview.alignment = .fill
        buttonStackview.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView = UIStackView.init(arrangedSubviews: [titleLabel, messageLabel, buttonStackview])
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        mainStackView.alignment = .center
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.spacing = 8
    }
    
    
    internal func _insertAndLayoutSubviews() {
        self.addSubview(alertContainer)
        alertContainer.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([mainStackView.leadingAnchor.constraint(equalTo: alertContainer.leadingAnchor),
                                     mainStackView.trailingAnchor.constraint(equalTo: alertContainer.trailingAnchor),
                                     mainStackView.topAnchor.constraint(equalTo: alertContainer.topAnchor,
                                                                        constant: 10),
                                     mainStackView.bottomAnchor.constraint(equalTo: alertContainer.bottomAnchor)])
        
        NSLayoutConstraint.activate([alertContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     alertContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     alertContainer.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
                                     alertContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 150)])
        
        NSLayoutConstraint.activate([titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
                                     titleLabel.widthAnchor.constraint(equalTo: alertContainer.widthAnchor, multiplier: 0.88),
                                     messageLabel.widthAnchor.constraint(equalTo: alertContainer.widthAnchor, multiplier: 0.88),
                                     buttonStackview.widthAnchor.constraint(equalTo: alertContainer.widthAnchor, multiplier: 1)])
    }
    
    internal func _config() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        setAligment()
    }
}


//    MARK: - Set aligment properties
extension MNkAlertView{
    
    private func setAligment(_ aligment:MNkAlertViewContentAligment = .center){
        switch aligment{
        case .leftRight,.rightLeft,.right,.left:
            setTo(aligment)
        case .center:
            setToCenter()
        }
    }
    
    private func setTo(_ aligment:MNkAlertViewContentAligment){
        let aligTopContent:NSTextAlignment = (aligment == MNkAlertViewContentAligment.left || aligment == MNkAlertViewContentAligment.leftRight) ? NSTextAlignment.left : .right
        let aligBottomContent:UIControl.ContentHorizontalAlignment = (aligment == MNkAlertViewContentAligment.left || aligment == MNkAlertViewContentAligment.rightLeft) ? UIControl.ContentHorizontalAlignment.left : .right
        let stackAligmnet:UIStackView.Alignment = (aligment == MNkAlertViewContentAligment.left || aligment == MNkAlertViewContentAligment.rightLeft) ? UIStackView.Alignment.leading : .trailing
        let leftACBtnPri:UILayoutPriority = (aligment == MNkAlertViewContentAligment.left || aligment == MNkAlertViewContentAligment.rightLeft) ? UILayoutPriority.defaultHigh : .defaultLow
        let rightACBtnPri:UILayoutPriority = (aligment == MNkAlertViewContentAligment.left || aligment == MNkAlertViewContentAligment.rightLeft) ? UILayoutPriority.defaultLow : .defaultHigh
        
        titleLabel.textAlignment = aligTopContent
        messageLabel.textAlignment = aligTopContent
        
        buttonStackview.distribution = .fill
        buttonStackview.alignment = stackAligmnet
        buttonStackview.spacing = 8
        
        leftActionButton.contentHorizontalAlignment = aligBottomContent
        rightActionButton.contentHorizontalAlignment = aligBottomContent
        
        leftActionButton.setContentHuggingPriority(leftACBtnPri, for: .horizontal)
        rightActionButton.setContentHuggingPriority(rightACBtnPri, for: .horizontal)
        
    }
    
    private func setToCenter(){
        titleLabel.textAlignment = .center
        messageLabel.textAlignment = .center
        
        buttonStackview.distribution = .fillEqually
        buttonStackview.alignment = .fill
        buttonStackview.spacing = 1
        
        leftActionButton.contentHorizontalAlignment = .center
        rightActionButton.contentHorizontalAlignment = .center
    }
    
}
