//
//  MNkVerticalAlignButton.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 9/11/18.
//
import UIKit
open class MNkVerticalAlignButton: UIView {
    
    
    
    public  var imageEdgeInset:UIEdgeInsets = .zero{
        didSet{
            setInsert()
        }
    }
    
    public var contentEdgeInset:UIEdgeInsets = .zero{
        didSet{
            setContentInset()
        }
    }
    
    public var titleHeightConstant:CGFloat = 0.0{
        didSet{
            titleHeightAnchor?.constant = titleHeightConstant
        }
    }
    
    @IBInspectable public var image:UIImage?{
        didSet{
            imageView.image = image
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
    
    @IBInspectable public var titleFont:UIFont = UIFont.systemFont(ofSize: 14){
        didSet{
            titleLabel.font = titleFont
        }
    }
    
    @IBInspectable public var imageTintColor:UIColor = .white{
        didSet{
            imageView.tintColor = imageTintColor
        }
    }
    public func setImage(from url:URL?,_ tintColor:UIColor? = nil,_ placeHolder:UIImage? = nil){
        imageView.setImage(with: url, tintColor: tintColor, plaseHolder: placeHolder)
    }
    
    private var titleHeightAnchor:NSLayoutConstraint?
    
    private var imageContainer:UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var imageView:UIImageView = {
        let iv = UIImageView()
        iv.tintColor = imageTintColor
        iv.image = image
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = title?.capitalized
        label.font = titleFont
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
    
    private var svLeadingAnchor:NSLayoutConstraint?
    private var svTralingAnchor:NSLayoutConstraint?
    private var svTopAnchor:NSLayoutConstraint?
    private var svBottomAnchor:NSLayoutConstraint?
    
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
        
        svLeadingAnchor = stackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8)
        svTralingAnchor = stackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8)
        svTopAnchor = stackView.topAnchor.constraint(equalTo: topAnchor,constant:  8)
        svBottomAnchor = stackView.bottomAnchor.constraint(equalTo: bottomAnchor,constant:-8)
        
        svLeadingAnchor?.isActive = true
        svTralingAnchor?.isActive = true
        svTopAnchor?.isActive = true
        svBottomAnchor?.isActive = true
        
        
        titleHeightAnchor = titleLabel.heightAnchor.constraint(equalToConstant: 34)
        titleHeightAnchor?.isActive = true
        
        
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
    
    private func setContentInset(){
        svLeadingAnchor?.constant = contentEdgeInset.left
        svTralingAnchor?.constant = -contentEdgeInset.right
        svTopAnchor?.constant = contentEdgeInset.top
        svBottomAnchor?.constant = -contentEdgeInset.bottom
    }
    
}

extension MNkVerticalAlignButton:UIGestureRecognizerDelegate{
    override open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        animateClick()
        return true
    }
}
