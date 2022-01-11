//
//  MNkAlertView_comp.swift
//  MNkSupportUtilities_Example
//
//  Created by Malith Kamburapola on 2022-01-11.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import MNkSupportUtilities

class MNkAlertView_Sample: MNkViewController {
    
    private lazy var showButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Show", for: .normal)
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(didTapShowButton), for: .touchUpInside)
        return btn
    }()
    
    override func insertAndLayoutSubviews() {
        view.addSubview(showButton)
        NSLayoutConstraint.activate([showButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     showButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                                     showButton.heightAnchor.constraint(equalToConstant: 50),
                                     showButton.widthAnchor.constraint(equalToConstant: 100)])
    }
    
    override func config() {
        super.config()
        view.backgroundColor = .green
    }
    
    @objc private func didTapShowButton() {
        showAlert()
//        showCustomAlert()
    }
    
    private func showAlert() {
        let alertView = MNkAlertView()
        alertView.titleLabel.text = "Confirm"
        alertView.messageLabel.text = "Do you want to proceed with these settings?"
        alertView.type = .multi
        
        alertView.action = { actionType, data in
            switch actionType {
            case .rightClick:
                print("Right Action")
                
            case .leftClick:
                print("Left Action")
                
            default:
                break
            }
        }
        
        let alertController = MNkAlertViewController()
        alertController.set(alertView: alertView)
        self.showAlert(of: alertController, aditional: nil)
    }
    
    private func showCustomAlert() {
        let alertView = CustomAlertView()
        alertView.titleLabel.text = "Saved"
        alertView.messageLabel.text = "New settings save successfully."
        
        alertView.action = { actionType, data in
            switch actionType {
            case .rightClick:
                print("Right Action")
                
            case .leftClick:
                print("Left Action")
                
            default:
                break
            }
        }
        
        let alertController = MNkAlertViewController()
        alertController.set(alertView: alertView)
        self.showAlert(of: alertController, aditional: nil)
    }
}




//MARK: - CUSTOM ALERT VIEW
class CustomAlertView: MNkAlertView {
    private var topStripView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var indicatorImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = .gearRoundFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override func createViews() {
        super.createViews()
        
        mainStackView.insertArrangedSubview(indicatorImageView, at: 0)
        mainStackView.spacing = 20
        
        rightActionButton.layer.cornerRadius = 3
        rightActionButton.backgroundColor = .lightBlue
        rightActionButton.setTitleColor(.white, for: .normal)
    }
    
    override func insertAndLayoutSubviews() {
        self.addSubview(alertContainer)
        alertContainer.addSubview(mainStackView)

        NSLayoutConstraint.activate([mainStackView.leadingAnchor.constraint(equalTo: alertContainer.leadingAnchor),
                                     mainStackView.trailingAnchor.constraint(equalTo: alertContainer.trailingAnchor),
                                     mainStackView.topAnchor.constraint(equalTo: alertContainer.topAnchor,
                                                                        constant: 20),
                                     mainStackView.bottomAnchor.constraint(equalTo: alertContainer.bottomAnchor,
                                                                           constant: -20)])

        NSLayoutConstraint.activate([alertContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     alertContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     alertContainer.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
                                     alertContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 150)])

        NSLayoutConstraint.activate([titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
                                     titleLabel.widthAnchor.constraint(equalTo: alertContainer.widthAnchor, multiplier: 0.88),
                                     messageLabel.widthAnchor.constraint(equalTo: alertContainer.widthAnchor, multiplier: 0.88),
                                     buttonStackview.widthAnchor.constraint(equalTo: alertContainer.widthAnchor, multiplier: 0.6)])
        
        NSLayoutConstraint.activate([indicatorImageView.widthAnchor.constraint(equalToConstant: 80),
                                     indicatorImageView.heightAnchor.constraint(equalTo: indicatorImageView.widthAnchor)])

        alertContainer.addSubview(topStripView)
        NSLayoutConstraint.activate([topStripView.topAnchor.constraint(equalTo: alertContainer.topAnchor),
                                     topStripView.leadingAnchor.constraint(equalTo: alertContainer.leadingAnchor),
                                     topStripView.trailingAnchor.constraint(equalTo: alertContainer.trailingAnchor),
                                     topStripView.heightAnchor.constraint(equalToConstant: 5)])
    }
    
    override func config() {
        backgroundColor = .clear
    }
}
