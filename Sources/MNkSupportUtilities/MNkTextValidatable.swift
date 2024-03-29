//
//  MNkTextValidatable.swift
//  MNkSupportUtilities
//
//  Created by Malith Nadeeshan on 3/25/19.
//
import UIKit

public typealias ValidationData = (textContainer: MNkValidatableTextView, type: ValidationType)

public protocol MNkValidatableTextView {
    var textView:UIView{get}
    var errorBorderView:UIView?{get}
    var errorLabel:UILabel?{get}
}

extension MNkValidatableTextView{
    public var errorBorderView:UIView?{
        return nil
    }
    public var errorLabel:UILabel?{
        return nil
    }
}



public protocol MNkTextValidatable{
    //    var hasEmptyTextContainer:Bool{get}
    var validationData: [ValidationData] { get }
    ///Color red
    var errorColor: UIColor { get }
    ///Color clear
    var backgroundColor: UIColor { get }
    ///Color white
    var textColor: UIColor { get }
     
    var borderColor: UIColor { get }
    
    var validationDisplayStyle: ValidationErrorDisplayType { get }
}

extension MNkTextValidatable{
    
    public var errorColor:UIColor{
        return #colorLiteral(red: 1, green: 0.462745098, blue: 0.4588235294, alpha: 1)
    }
    public var backgroundColor:UIColor{
        return .clear
    }
    public var textColor:UIColor{
        return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    public var borderColor:UIColor{
        return .clear
    }
    
    public var validationDisplayStyle:ValidationErrorDisplayType{
        return .backgroundOnly
    }
    
    private func checkEmptyTextContainer(with defaultError: String )->Bool{
        var hasEmpty:Bool = false
        for data in validationData {
            
            let textContainer = data.textContainer
            setTextContainer(toDefault: true, textContainer, defaultError)
            
            guard ((textContainer.textView.textString?.isEmpty) != nil) else { continue }
            setTextContainer(toDefault: false, textContainer, defaultError)
            
            hasEmpty = true
        }
        return hasEmpty
    }
    
    private func isEmpty(_ textField:MNkValidatableTextView)->Bool{
        guard textField.textView.textString == "" else{
            setTextContainer(toDefault: true, textField)
            return false
        }
        setTextContainer(toDefault: false, textField)
        return true
    }
    
    private func setTextContainer(toDefault isDefault: Bool, _ textContainer: MNkValidatableTextView, _ error: String = "Need to fill required fields"){
        
        guard !isDefault else{
            textContainer.textView.backgroundColor = backgroundColor
            textContainer.textView.setTextColor(textColor)
            textContainer.errorLabel?.text = ""
            textContainer.errorBorderView?.backgroundColor = borderColor
            return
        }
        
        switch validationDisplayStyle{
        case .backgroundOnly:
            textContainer.textView.backgroundColor =  errorColor
            textContainer.textView.setTextColor(backgroundColor)
            
        case .backgroundErrorMessages:
            textContainer.textView.backgroundColor =  errorColor
            textContainer.textView.setTextColor(backgroundColor)
            
            textContainer.errorLabel?.textColor = errorColor
            textContainer.errorLabel?.text = isDefault ? "" : error
            
        case .boderOnly:
            textContainer.errorBorderView?.backgroundColor = errorColor
            
        case .borderErrorMessages:
            textContainer.errorBorderView?.backgroundColor = errorColor
            textContainer.errorLabel?.textColor = errorColor
            textContainer.errorLabel?.text = isDefault ? "" : error
            
        case .text:
            textContainer.textView.setTextColor(errorColor)
            
        case .errorMessageOnly:
            textContainer.errorLabel?.textColor = errorColor
            textContainer.errorLabel?.text = isDefault ? "" : error
        }
        
    }
    
    
    //MARK:- VALIDATE TEXT FIELD DATA ACORDING TO IT TYPE
    
    ///Validate data of given validatable text areas.
    @discardableResult
    public func validate(withDefaultErrorMsg defaultErrorMsg:String = "Need to fill required fields") -> ValidatedData {
        
        var password:String!
        
        var validatedData = ValidatedData()
        
        
        for data in validationData {
            
            let _textContainer = data.textContainer
            let _validationType = data.type
            
            //Set to default
            setTextContainer(toDefault: true, _textContainer)
            
            switch _validationType{
            case .email:
                let result = validateEmail(in:_textContainer.textView)
                let error = "Please enter valid email"
                setTextContainer(toDefault: result, _textContainer,error)
                if !result{
                    validatedData.isValidate = false
                    validatedData.errors.append(error)
                }
                continue
                
            case let .phoneNo(required):
                let result = validatePhoneNo(in: _textContainer.textView, isRequired: required)
                let error = "Please enter valid phone number"
                
                setTextContainer(toDefault: result, _textContainer,error)
                
                if !result{
                    validatedData.isValidate = false
                    validatedData.errors.append(error)
                }
                continue
                
            case .mobileDialog:
                let result = validateMobileNo(in: _textContainer.textView, for: .dialog)
                let error = "Please enter Dailog mobile number"
                setTextContainer(toDefault: result, _textContainer,error)
                if !result{
                    validatedData.isValidate = false
                    validatedData.errors.append(error)
                }
                continue
            case .mobileMobitel:
                let result = validateMobileNo(in: _textContainer.textView, for: .mobitel)
                let error = "Please enter Mobitel mobile number"
                setTextContainer(toDefault: result, _textContainer,error)
                if !result{
                    validatedData.isValidate = false
                    validatedData.errors.append(error)
                }
                continue
            case .password:
                password = _textContainer.textView.textString ?? ""
                let result = password.count >= 6 ? true : false
                let error = "The password must be 6 characters long or more"
                setTextContainer(toDefault: result, _textContainer,error)
                if !result{
                    validatedData.isValidate = false
                    validatedData.errors.append(error)
                }
                continue
            case .conformPassword:
                if let _password = password{
                    let result = _password == _textContainer.textView.textString ?? ""
                    let error = "password not matched"
                    setTextContainer(toDefault: result, _textContainer,error)
                    if !result{
                        validatedData.isValidate = false
                        validatedData.errors.append(error)
                    }
                }
                continue
            case .normal:
                let text = data.textContainer.textView.textString
                let result = text?.isEmpty ?? true
                setTextContainer(toDefault: !result, _textContainer)
                if result{
                    validatedData.isValidate = false
                    validatedData.errors.append(defaultErrorMsg)
                }
                continue
            }
        }
        
        if validatedData.errors.count > 1{
            validatedData.commonError = defaultErrorMsg
        }
        
        if validatedData.errors.count == 1{
            validatedData.commonError = validatedData.errors.first
        }
        
        return validatedData
    }
    
    private func validateEmail(in emailTextContainer:UIView)->Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailTextContainer.textString)
    }
    
    private func validatePhoneNo(in textContainer: UIView, isRequired: Bool = true)->Bool {
        
        guard let text = textContainer.textString, text != "" else { return isRequired ? false : true }
        
        let formattedPN = formatPhoneNo(text)
        
        guard let _ = Int(formattedPN) else{return false}
        guard formattedPN.count == 9 else{return false}
        return true
    }
    
    private func validateMobileNo(in textContainer:UIView,for carrierType:CarrierType)->Bool{
        
        guard let text = textContainer.textString,text != "" else {return true}
        
        guard validatePhoneNo(in: textContainer) else{return false}
        
        let mobileNo = formatPhoneNo(text)
        
        let prefex = String(mobileNo.prefix(2))
        
        var isPassed = false
        
        switch carrierType{
        case .dialog:
            switch prefex{
            case "77","76":
                isPassed = true
            default:
                isPassed = false
            }
        case .mobitel:
            switch prefex{
            case "71","70":
                isPassed = true
            default:
                isPassed = false
            }
        }
        return isPassed
        
    }
    
    public func formatPhoneNo(_ mobileNo:String)->String{
        var formattedPN = String(mobileNo.filter{ !" \n\t\r()-".contains($0)})
        
        if let firtString = formattedPN.first?.description,
            firtString != " ",
            firtString == "0"{
            formattedPN.remove(at: mobileNo.startIndex)
        }
        
        return formattedPN
    }
    
}

///Types of validation options
public enum ValidationType {
    case normal
    case email
    case phoneNo(isRequired: Bool)
    case password
    case conformPassword
    case mobileDialog
    case mobileMobitel
}

enum CarrierType{
    case dialog
    case mobitel
}


extension UIView{
    var textString:String?{
        return (self as? UILabel)?.text ?? (self as? UITextView)?.text ?? (self as? UITextField)?.text
    }
    func setTextColor(_ color:UIColor){
        let label = self as? UILabel
        label?.textColor = color
        
        let textView = self as? UITextView
        textView?.textColor = color
        
        let textField = self as? UITextField
        textField?.textColor = color
    }
}

///Error display type of form text area.
public enum ValidationErrorDisplayType{
    case backgroundOnly
    case backgroundErrorMessages
    case boderOnly
    case borderErrorMessages
    case text
    case errorMessageOnly
}

///Data returned after validate called.
public struct ValidatedData{
    public var isValidate:Bool = true
    ///All Errors array generate in validation process
    public var errors:[String] = []
    ///Return common validation error if there is more than one validation errors.
    public var commonError:String?
    
}
