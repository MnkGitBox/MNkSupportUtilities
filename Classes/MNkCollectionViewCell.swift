//
//  MNkCollectionViewCell.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 27/12/18.
//
import UIKit

open class MNkCVCell_Parameter<T>: MNkCollectionViewCell {
    
    public var data:T?{
        didSet{
            guard let _data = data else{return}
            updateUI(with:_data)
        }
    }
    
    open func updateUI(with data:T){}

}





open class MNkCollectionViewCell:UICollectionViewCell{
    open func createViews(){}
    open func insertAndLayoutSubviews(){}
    open func config(){}
    
    open func setAppSetting(){}
    
    private func doLoadThings(){
        backgroundColor = .white
        createViews()
        insertAndLayoutSubviews()
        config()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        doLoadThings()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doLoadThings()
    }

    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        setAppSetting()
    }
}





class MNkEmptyCVCell:MNkCollectionViewCell{
    
    var message:String?{
        didSet{
            messageLabel.text = message
        }
    }
    
    var heading:String?{
        didSet{
            headingLabel.text = heading
        }
    }
    
    var placeHolderImage:UIImage?{
        didSet{
            imageview.image = placeHolderImage
        }
    }
    
    var isHideButton:Bool = false{
        didSet{
            retryButton.isHidden = isHideButton
        }
    }
    
    private let imageview:UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .lightGray
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let headingLabel:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        lbl.textColor = .black
        lbl.textAlignment = .center
        return lbl
    }()
    private var messageLabel:UILabel!
    private var retryButton:UIButton!
    
    private let stackview:UIStackView = {
        let sv = UIStackView()
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 8
        sv.axis = .vertical
        return sv
    }()
    
    override func createViews() {
        messageLabel = UILabel()
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.textColor = .lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.lineBreakMode = .byCharWrapping
        
        retryButton = UIButton()
        retryButton.setTitle("RETRY", for: .normal)
        retryButton.setTitleColor(.white, for: .normal)
        retryButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        retryButton.backgroundColor = .blue
        retryButton.layer.cornerRadius = 3
        retryButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func insertAndLayoutSubviews() {
        addSubview(stackview)
        stackview.addArrangedSubview(imageview)
        stackview.addArrangedSubview(headingLabel)
        stackview.addArrangedSubview(messageLabel)
        addSubview(retryButton)
        
        stackview.activateLayouts(to: self, [.centerY : 0,.centerX:0])
        NSLayoutConstraint.activate([stackview.widthAnchor.constraint(equalTo: self.widthAnchor,
                                                                      multiplier: 0.6),
                                     imageview.heightAnchor.constraint(equalTo: imageview.widthAnchor)])
        
        NSLayoutConstraint.activate([retryButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     retryButton.heightAnchor.constraint(equalToConstant: 36),
                                     retryButton.widthAnchor.constraint(equalTo: self.widthAnchor,
                                                                        multiplier: 0.4),
                                     retryButton.topAnchor.constraint(equalTo: stackview.bottomAnchor,
                                                                      constant: 20)])
    }
    
    override func config() {
        clipsToBounds = true
    }
}
