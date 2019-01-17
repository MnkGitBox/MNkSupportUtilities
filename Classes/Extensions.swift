//
//  Extensions.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 5/11/18.
//

import Foundation

//-------------------------------------------//
//UIView Extenstions
//-------------------------------------------//
public extension UIView{
    public func activeShadow(using opacity:Float = 0.1,shadowRadius:CGFloat = 8,_ offSet:CGSize = CGSize(width: 0, height: 1)){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = opacity
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
    
    public func addCornerRadius(){
        self.layer.cornerRadius = self.bounds.size.width * 0.03
        self.clipsToBounds = true
    }
    
    public func addCornerRadius(to corners:UIRectCorner,_ radius:CGFloat){
        
        let path = UIBezierPath(roundedRect:self.bounds,
                                byRoundingCorners:corners,
                                cornerRadii: CGSize(width: radius, height:  radius))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    
    
    //UIView layout extensions
    public func activateLayouts(equalConstant value:CGFloat = 0,to parentView:UIView){
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor,
                                                                   constant: value),
                                     self.trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor,
                                                                    constant: -value),
                                     self.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor,
                                                               constant: value),
                                     self.bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor,
                                                                  constant: -value)])
    }
    
    public func activateLayouts(to parentView:UIView = UIView(),_ layouts:[MNkLayoutKeys:CGFloat]){
        for val in layouts{
            activateLayout(to: parentView, val.key, val.value)
        }
    }
    
    public func activateLayouts(to layoutsConfig:[UIView:[MNkLayoutKeys:CGFloat]]){
        for config in layoutsConfig{
            for layout in config.value{
                activateLayout(to: config.key, layout.key, layout.value)
            }
        }
    }
    
    public func activateLayout(to view:UIView,_ layoutKey:MNkLayoutKeys,_ constant:CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        switch layoutKey{
        case .traling:
            self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: constant).isActive = true
        case .leading:
            self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: constant).isActive = true
        case .top:
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:constant).isActive = true
        case .centerY:
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        case .centerX:
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:constant).isActive = true
        case .bottom:
            self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant:constant).isActive = true
        case .height:
            self.heightAnchor.constraint(equalToConstant: constant).isActive = true
        case .width:
            self.widthAnchor.constraint(equalToConstant: constant).isActive = true
        }
    }
    
    enum MNkLayoutKeys{
        case top
        case leading
        case traling
        case bottom
        case centerX
        case centerY
        case height
        case width
    }
    
}

//-------------------------------------------//
//UIimageview Extenstions
//-------------------------------------------//

import SDWebImage
extension UIImageView{
    func setImage(with url:URL?,tintColor tColor:UIColor?,plaseHolder plImage:UIImage? = nil,options sdwedImageOptions:SDWebImageOptions = []){
        var renderingMode:UIImageRenderingMode = .alwaysOriginal
        if tColor != nil{
            renderingMode = .alwaysTemplate
        }
        sd_setImage(with: url, placeholderImage: plImage, options: sdwedImageOptions) { [weak self]image, _,_, _ in
            let _image = image?.withRenderingMode(renderingMode)
            self?.tintColor = tColor
            self?.image = _image
        }
    }
}

