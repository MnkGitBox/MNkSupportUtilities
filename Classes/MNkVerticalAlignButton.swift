//
//  MNkVerticalAlignButton.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 9/11/18.
//

import UIKit

open class MNkVerticalAlignButton: UIView {
    
    public var imageUrl:URL?{
        didSet{
            guard isWantTintColor else{return}
            imageView.setImage(with: imageUrl, tintColor: imageTintColor)
        }
    }
    
    public  var imageEdgeInset:UIEdgeInsets = .zero{
        didSet{
            setInsert()
        }
    }
    
    @IBInspectable public var image:UIImage = #imageLiteral(resourceName: "missing icon"){
        didSet{
            
            let imageMode:UIImageRenderingMode = isWantTintColor ? UIImageRenderingMode.alwaysTemplate : .alwaysOriginal
            imageView.image = image.withRenderingMode(imageMode)
        }
    }
    @IBInspectable public  var title:String? = "Custom Button"{
        didSet{
            titleLabel.text = title?.capitalized
        }
    }
     @IBInspectable public var titleFontColor:UIColor = .white{
        didSet{
            titleLabel.textColor = titleFontColor
        }
    }
    @IBInspectable public var titleFontSize:CGFloat = 12{
        didSet{
            titleLabel.font = UIFont(name: "AvenirNext-Medium", size: titleFontSize)
        }
    }
    @IBInspectable public var imageTintColor:UIColor = .white{
        didSet{
            imageView.tintColor = imageTintColor
        }
    }
    @IBInspectable public var isWantTintColor:Bool = false{
        didSet{
            let renderingMode:UIImageRenderingMode = isWantTintColor ? .alwaysTemplate : .alwaysOriginal
            imageView.image = image.withRenderingMode(renderingMode)
        }
    }
    
    private var imageContainer:UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var imageView:UIImageView = {
        let iv = UIImageView()
        let imageMode:UIImageRenderingMode = isWantTintColor ? UIImageRenderingMode.alwaysTemplate : .alwaysOriginal
        iv.tintColor = imageTintColor
        iv.image = image.withRenderingMode(imageMode)
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = title?.capitalized
        label.font = UIFont(name: "AvenirNext-Medium", size: titleFontSize)
        label.textColor = titleFontColor
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var tapGestureRecognizer = UITapGestureRecognizer()
    
    private var imageLeftConstant:NSLayoutConstraint?
    private var imageRightConstant:NSLayoutConstraint?
    private var imageTopConstant:NSLayoutConstraint?
    private var imageBottomConstant:NSLayoutConstraint?
    
    public func insertAndLayoutSubViews(){
        
        imageContainer.addSubview(imageView)
        imageLeftConstant = imageView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor,
                                                               constant:imageEdgeInset.left)
        imageRightConstant = imageView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor,
                                                                 constant:-imageEdgeInset.right)
        imageTopConstant = imageView.topAnchor.constraint(equalTo: imageContainer.topAnchor,
                                                          constant:imageEdgeInset.top)
        imageBottomConstant = imageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor,
                                                                constant:-imageEdgeInset.bottom)
        
        imageLeftConstant?.isActive = true
        imageRightConstant?.isActive = true
        imageTopConstant?.isActive = true
        imageBottomConstant?.isActive = true
        
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(imageContainer)
        stackView.addArrangedSubview(titleLabel)
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([stackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                                        constant: 8),
                                     stackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                                         constant: -8),
                                     stackView.topAnchor.constraint(equalTo: topAnchor,
                                                                    constant:  8),
                                     stackView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                                       constant:-8)])
        
        titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
        
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        doInitialWork()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doInitialWork()
    }
    
    private func doInitialWork(){
        self.addGestureRecognizer(tapGestureRecognizer)
        self.tapGestureRecognizer.delegate = self
        insertAndLayoutSubViews()
    }
    
    func addTarget(target:Any,_ selector:Selector){
        self.tapGestureRecognizer.addTarget(target, action: selector)
    }
    
    fileprivate func animateClick(){
        
        UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: .calculationModeCubic, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.1, animations: {
                self.transform = .identity
            })
            
        }, completion: nil)
    }
    
    private func setInsert(){
        imageLeftConstant?.constant = imageEdgeInset.left
        imageRightConstant?.constant = -imageEdgeInset.right
        imageBottomConstant?.constant = -imageEdgeInset.bottom
        imageTopConstant?.constant = imageEdgeInset.top
    }
    
}

extension MNkVerticalAlignButton:UIGestureRecognizerDelegate{
    override open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        animateClick()
        return true
    }
}
