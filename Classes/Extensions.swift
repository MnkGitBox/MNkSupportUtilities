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
    
    ///Add borders to specific corners
    @discardableResult
    func addBorders(edges: UIRectEdge,
                    color: UIColor,
                    inset: CGFloat = 0.0,
                    thickness: CGFloat = 1.0) -> [UIView] {

        var borders = [UIView]()

        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap {
                NSLayoutConstraint.constraints(withVisualFormat: $0,
                                               options: [],
                                               metrics: ["inset": inset, "thickness": thickness],
                                               views: ["border": border]) })
            borders.append(border)
            return border
        }


        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }

        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }

        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }

        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }

        return borders
    }

    ///Inser gradient layer to view
    func insertGradientLayer(top topColor: UIColor, bottom bottomColor: UIColor) {
        let layer = CAGradientLayer()
        layer.colors = [topColor.cgColor, bottomColor.cgColor]
        layer.locations = [0.0,1.0]
        layer.frame = self.bounds
        
        self.layer.insertSublayer(layer, at: 0)
    }
    
    ///Remove all constraint
    func removeAllConstraints() {
        var _superview = self.superview
        
        while let superview = _superview {
            for constraint in superview.constraints {
                
                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }
                
                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }
            
            _superview = superview.superview
        }
        
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
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
    
    ///UICollectionViewFlowLayout will assign to collection view object with given frame
    convenience init(_ frame:CGRect = .zero) {
        let layout = UICollectionViewFlowLayout()
        
        self.init(frame: frame, collectionViewLayout: layout)
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
    
    static var uniqueID: String { UUID().uuidString }
    
    func toDate(withFormat format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        let dateString = self.split(separator: "T").first ?? ""
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: dateString.description) else {
            return Date()
        }
        return date
    }
    
    var underLine: NSMutableAttributedString {
        let underLineString = NSMutableAttributedString.init(string: self)
        underLineString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange.init(location: 0, length: self.count))
        
        return underLineString
    }
    
    var withoutSpecialCharacters: String {
        return self.components(separatedBy: CharacterSet.symbols).joined(separator: "")
    }
}

public extension NSMutableAttributedString {
    @discardableResult
    func underLine() -> Self {
        self.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange.init(location: 0, length: self.string.count))
        return self
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
public extension Int {
    var withLeadingZero: String {
        return self < 10 ? "0"+"\(self)" : "\(self)"
    }
    
    
}

//MARK: - UISCROLLVIEW
public extension UIScrollView {
    func  isNearBottomEdge(edgeOffset: CGFloat = 20) -> Bool {
        return self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
}

//MARK: - ARRAY
public extension Array {
    mutating func move(from: Int, _ to : Int) {
        guard to >= 0, to < self.count,
            from >= 0, from < self.count else { return }
        let element = self.remove(at: from)
        self.insert(element, at: to)
    }
    
    mutating func replace(new element: Element, equal: (Element) -> Bool ) {
        guard let index = self.firstIndex(where: equal) else { return }
        self[index] = element
    }
}

public extension BidirectionalCollection where Element: StringProtocol {
    var list: String {
        guard let `last` = last else { return "" }
        return count <= 1 ? joined(separator: "") : dropLast().joined(separator: "\n") + last
    }
}

//MARK: - UIONTROL
public extension UIControl {
    enum AnimationPosition {
        case left
        case middle
        case right
        
        var multipy: CGFloat {
            switch self {
            case .left:
                return 0.2
                
            case .middle:
                return 0.5
                
            case .right:
                return 0.8
            }
        }
    }
    
    func activeLoad(_ isLoad: Bool, at position: AnimationPosition = .left, style indicatorStyle:UIActivityIndicatorView.Style = .white ) {
        let tag = 920130
        if isLoad {
            self.isEnabled = false
            self.alpha = 0.5
            let activityIndicator = UIActivityIndicatorView.init(style: indicatorStyle)
            let leading = self.bounds.width * position.multipy
            activityIndicator.center = .init(x: leading, y: self.bounds.height * 0.5)
            activityIndicator.tag = tag
            self.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        } else {
            self.isEnabled = true
            self.alpha = 1
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}


public extension UIWindow {
    static func visibleWindow() -> UIWindow? {
        var currentWindow = UIApplication.shared.keyWindow
        
        if currentWindow == nil {
            let frontToBackWindows = Array(UIApplication.shared.windows.reversed())
            
            for window in frontToBackWindows {
                if window.windowLevel == UIWindow.Level.normal {
                    currentWindow = window
                    break
                }
            }
        }
        
        return currentWindow
    }
}

//MARK: - TIME INTERVAL
public extension TimeInterval {
    ///Get time interval past to now. 'eg: - 2d ago'
    var formatInterval: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.year, .month, .weekday, .day, .hour, .minute, .second]
        formatter.unitsStyle = .short
        formatter.maximumUnitCount = 1

        return formatter.string(from: self)!
    }
}


//MARK: - DATE
public extension Date {
    ///Remaining days to future event. 'eg: - 2 more days'
    var remainDaysFromNow: Int {
        let now = Date()
        let calender = Calendar.current
        let startDate = calender.startOfDay(for: now)
        let endDate = calender.startOfDay(for: self)
        
        return calender.dateComponents([.day], from: startDate, to: endDate).day ?? 0
    }
}
