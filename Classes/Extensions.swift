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
    func activeShadow(using opacity:Float = 0.1,shadowRadius:CGFloat = 8,_ offSet:CGSize = CGSize(width: 0, height: 1)){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = opacity
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
    
    func addCornerRadius(){
        self.layer.cornerRadius = self.bounds.size.width * 0.03
        self.clipsToBounds = true
    }
    
    func addCornerRadius(to corners:UIRectCorner,_ radius:CGFloat){
        
        let path = UIBezierPath(roundedRect:self.bounds,
                                byRoundingCorners:corners,
                                cornerRadii: CGSize(width: radius, height:  radius))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    
    
    //UIView layout extensions
    func activateLayouts(equalConstant value:CGFloat = 0,to parentView:UIView,_ isSafeAreaActivate:Bool = false){
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([self.leadingAnchor.constraint(equalTo: isSafeAreaActivate ? parentView.safeAreaLayoutGuide.leadingAnchor : parentView.leadingAnchor,
                                                                   constant: value),
                                     self.trailingAnchor.constraint(equalTo: isSafeAreaActivate ? parentView.safeAreaLayoutGuide.trailingAnchor : parentView.trailingAnchor,
                                                                    constant: -value),
                                     self.topAnchor.constraint(equalTo: isSafeAreaActivate ? parentView.safeAreaLayoutGuide.topAnchor : parentView.topAnchor,
                                                               constant: value),
                                     self.bottomAnchor.constraint(equalTo: isSafeAreaActivate ? parentView.safeAreaLayoutGuide.bottomAnchor : parentView.bottomAnchor,
                                                                  constant: -value)])
    }
    
    func activateLayouts(to parentView:UIView = UIView(),_ layouts:[MNkLayoutKeys:CGFloat],_ isSafeAreaActivate:Bool = false){
        for val in layouts{
            activateLayout(to: parentView, val.key, val.value,isSafeAreaActivate)
        }
    }
    
    func activateLayouts(to layoutsConfig:[UIView:[MNkLayoutKeys:CGFloat]],_ isSafeAreaActivate:Bool = false){
        for config in layoutsConfig{
            for layout in config.value{
                activateLayout(to: config.key, layout.key, layout.value,isSafeAreaActivate)
            }
        }
    }
    
    func activateLayout(to view:UIView,_ layoutKey:MNkLayoutKeys,_ constant:CGFloat,_ isSafeAreaActivate:Bool = false){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        switch layoutKey{
        case .traling:
            self.trailingAnchor.constraint(equalTo: isSafeAreaActivate ? view.safeAreaLayoutGuide.trailingAnchor : view.trailingAnchor,
                                           constant: constant).isActive = true
        case .leading:
            self.leadingAnchor.constraint(equalTo: isSafeAreaActivate ? view.safeAreaLayoutGuide.leadingAnchor : view.leadingAnchor,
                                          constant: constant).isActive = true
        case .top:
            self.topAnchor.constraint(equalTo: isSafeAreaActivate ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor,
                                      constant:constant).isActive = true
        case .centerY:
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        case .centerX:
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:constant).isActive = true
        case .bottom:
            self.bottomAnchor.constraint(equalTo: isSafeAreaActivate ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor,
                                         constant:constant).isActive = true
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
        var renderingMode:UIImage.RenderingMode = .alwaysOriginal
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

