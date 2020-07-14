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
    func activeShadow(using color:UIColor,opacity:Float = 0.1,shadowRadius:CGFloat = 8,_ offSet:CGSize = CGSize(width: 0, height: 1)){
        self.layer.shadowColor = color.cgColor
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
    func activateLayouts(equalConstant value:CGFloat = 0,to view:UIView? = nil,_ isSafeAreaActivate:Bool = false){
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var parentView:UIView!
        
        if view == nil{
            parentView = self.superview
        }else{
            parentView = view
        }
        
        guard parentView != nil else{
            fatalError("First add \(self.description) to view hirachy before layout")
        }
        
        NSLayoutConstraint.activate([self.leadingAnchor.constraint(equalTo: isSafeAreaActivate ? parentView.safeAreaLayoutGuide.leadingAnchor : parentView.leadingAnchor,
                                                                   constant: value),
                                     self.trailingAnchor.constraint(equalTo: isSafeAreaActivate ? parentView.safeAreaLayoutGuide.trailingAnchor : parentView.trailingAnchor,
                                                                    constant: -value),
                                     self.topAnchor.constraint(equalTo: isSafeAreaActivate ? parentView.safeAreaLayoutGuide.topAnchor : parentView.topAnchor,
                                                               constant: value),
                                     self.bottomAnchor.constraint(equalTo: isSafeAreaActivate ? parentView.safeAreaLayoutGuide.bottomAnchor : parentView.bottomAnchor,
                                                                  constant: -value)])
    }
    
    func activateLayouts(to parentView:UIView? = nil,_ layouts:[MNkLayoutKeys:CGFloat],_ isSafeAreaActivate:Bool = false){
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
    
    func activateLayout(to view:UIView?,_ layoutKey:MNkLayoutKeys,_ constant:CGFloat,_ isSafeAreaActivate:Bool = false){
        
        var parentView:UIView!
        
        if view == nil{
            parentView = self.superview
        }else{
            parentView = view
        }
        
        guard parentView != nil else{
            fatalError("First add \(self.description) to view hirachy before layout")
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        switch layoutKey{
        case .traling:
            self.trailingAnchor.constraint(equalTo: isSafeAreaActivate ? parentView.safeAreaLayoutGuide.trailingAnchor : parentView.trailingAnchor,
                                           constant: constant).isActive = true
        case .leading:
            self.leadingAnchor.constraint(equalTo: isSafeAreaActivate ? parentView.safeAreaLayoutGuide.leadingAnchor : parentView.leadingAnchor,
                                          constant: constant).isActive = true
        case .top:
            self.topAnchor.constraint(equalTo: isSafeAreaActivate ? parentView.safeAreaLayoutGuide.topAnchor : parentView.topAnchor,
                                      constant:constant).isActive = true
        case .centerY:
            self.centerYAnchor.constraint(equalTo: parentView.centerYAnchor, constant: constant).isActive = true
        case .centerX:
            self.centerXAnchor.constraint(equalTo: parentView.centerXAnchor, constant:constant).isActive = true
        case .bottom:
            self.bottomAnchor.constraint(equalTo: isSafeAreaActivate ? parentView.safeAreaLayoutGuide.bottomAnchor : parentView.bottomAnchor,
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
public extension UIImageView{
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

/*.................................
 MARK:- UICollectionView extensions
 ..........................................*/
public extension UICollectionView{
    func attributeFrame(forCellAt indexPath:IndexPath)->CGRect?{
        let attrib = self.layoutAttributesForItem(at: indexPath)
        return attrib?.frame
    }
}

//MARK:- STRING EXTENSIONS
public extension String{
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat{
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    
    func formatDate()->String{
        let array = self.split(separator: "T")
        if array.count > 0{
            return String(array.first ?? "")
        }
        return ""
    }
    
    func getFormattedMonthAndDate(withFormat format: String = "yyyy-MM-dd") -> String {
        let dateToFormat = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: dateToFormat) else {
            print("Date formatting error")
            return "Error with the date"
        }
        dateFormatter.dateFormat = "LLL"
        let nameOfMonth = dateFormatter.string(from: date)
        
        let dateArray = dateToFormat.split(separator: "-")
        var formattedDate:String!
        if dateArray.count > 0{
            formattedDate = "\(dateArray.last ?? ""), \(nameOfMonth)"
            return formattedDate
        }
        return formattedDate
    }
    
    func width(for font:UIFont)->CGFloat{
        var _width:CGFloat = 0
        let fontAttrib = [NSAttributedString.Key.font:font]
        let nsString = self as NSString
        _width = nsString.size(withAttributes: fontAttrib).width
        return _width
        
    }
    
    func formatToPhoneNo()->String{
        guard self.count == 10 else{return self}
        return self.insertToRange(of: " ", to: [3,7])
    }
    
    func insertToRange(of char:Character,to places:[Int])->String{
        var text = self
        for i in places{
            let index = self.index(self.startIndex, offsetBy: i)
            text.insert(char, at: index)
        }
        return text
    }
    
    ///Remove all white spoaces and new lines
    var removingAllWhitespacesAndNewlines: Self {
        return filter { !$0.isNewline && !$0.isWhitespace }
    }
    
    var price:Double?{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "LKR "
        guard let priceNumber = formatter.number(from: self) else{return nil}
        return priceNumber.doubleValue
    }
    
    ///Remove leading and traling white space and new line
    var removeWhiteSpace:Self{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

//MARK:- DOUBLE EXTENSIONS
public extension Double {
    func stringWithDoubDecimalPlace()->String{
        return String(format: "%.2f", self)
    }
    
    var formatCurreny:String?{
        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "LKR "
        
        guard let formattedPrice = numberFormatter.string(from: NSNumber.init(value: self))
            else{
                return nil
        }
        return formattedPrice
    }
}

//MARK:- UINAVIGATION ITEM EXTENSION
public extension UINavigationItem{
    func setEmptyBackButton(){
        self.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

//MARK:- UINAVIGATION BAR EXTENSION
public extension UINavigationBar{
    func activeTransparentNavBar(_ isActive:Bool){
        setBackgroundImage(isActive ? UIImage() : nil, for: .default)
        shadowImage = isActive ? UIImage() : nil
    }
}

//MARK:- UISTACKVIEW EXTENSION
public extension UIStackView{
    func removeAllArrangeSubViews(){
        for view in arrangedSubviews{
            self.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
    func addArrangeSubViews(_ views:[UIView]){
        for index in 0..<views.count{
            self.addArrangedSubview(views[index])
        }
    }
}

//MARK:- UITEXTFIELD  EXTENSION
public extension UITextField{
    var isEmpty:Bool{
        return (self.text == nil || self.text == "")
    }
}

//MARK:- UITEXTVIEW EXTENSION
public extension UITextView{
    func limitText(to maxCharCount:Int)->(validRangetext:String,remainNumber:String){
        let text = self.text
        let validRangeString = String(text?.prefix(maxCharCount) ?? "")
        let textCount = validRangeString.count
        self.text = validRangeString
        return (validRangeString,"\(textCount)/\(maxCharCount)")
    }
}

//MARK:- Int EXTENSION
public extension Int{
    var withLeadingZero:String{
        return self < 10 ? "0"+"\(self)" : "\(self)"
    }
}
