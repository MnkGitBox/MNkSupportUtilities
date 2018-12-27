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
