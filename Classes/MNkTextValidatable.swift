//
//  MNkTextValidatable.swift
//  MNkSupportUtilities
//
//  Created by Malith Nadeeshan on 3/25/19.
//

import Foundation

public typealias ValidationData = (textContainer:MNkValidatableTextView,type:ValidationType)

public protocol MNkValidatableTextView{
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
    var hasEmptyTextContainer:Bool{get}
    var validationData:[ValidationData]{get}
    var errorColor:UIColor{get}
    var defaultColor:UIColor{get}
    var textColor:UIColor{get}
    var borderColor:UIColor{get}
    var validationDisplayStyle:ValidationErrorDisplayType{get}
}

extension MNkTextValidatable{
    
    public var errorColor:UIColor{
        return #colorLiteral(red: 1, green: 0.462745098, blue: 0.4588235294, alpha: 1)
    }
    public var defaultColor:UIColor{
        return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    public var textColor:UIColor{
        return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    public var borderColor:UIColor{
        return .lightGray
    }
    
    public var validationDisplayStyle:ValidationErrorDisplayType{
        return .backgroundOnly
    }
    
    //MARK:- CHECK IS THERE ANY EMPTY TEXT FIELD
    public var hasEmptyTextContainer:Bool{
        return checkEmptyTextContainer()
    }
    
    private func checkEmptyTextContainer()->Bool{
        var hasEmpty:Bool = false
        for data in validationData{
            
            let textContainer = data.textContainer
            setTextContainer(toDefault: true, textContainer)
            
            guard textContainer.textView.textString == "" else{continue}
            setTextContainer(toDefault: false, textContainer)
            
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
    
    private func setTextContainer(toDefault isDefault:Bool,_ textContainer:MNkValidatableTextView,_ error:String = "Need to fill required fields"){
        
        guard !isDefault else{
            textContainer.textView.backgroundColor = defaultColor
            textContainer.textView.setTextColor(textColor)
            textContainer.errorLabel?.text = ""
            textContainer.errorBorderView?.backgroundColor = borderColor
            return
        }
        
        switch validationDisplayStyle{
        case .backgroundOnly:
            textContainer.textView.backgroundColor =  errorColor
            textContainer.textView.setTextColor(defaultColor)
        case .backgroundErrorMessages:
            textContainer.textView.backgroundColor =  errorColor
            textContainer.textView.setTextColor(defaultColor)
            textContainer.errorLabel?.text = isDefault ? "" : error
        case .boderOnly:
            textContainer.errorBorderView?.backgroundColor = errorColor
        case .borderErrorMessages:
            textContainer.errorBorderView?.backgroundColor = errorColor
            textContainer.errorLabel?.text = isDefault ? "" : error
        }
        
    }
    
    
    //MARK:- VALIDATE TEXT FIELD DATA ACORDING TO IT TYPE
    
    ///Validate data of given validatable text areas.
    public func validate(withDefaultErrorMsg defaultErrorMsg:String = "Need to fill required fields")->ValidatedData{
        
        var password:String = ""
        
        var validatedData = ValidatedData()

        
        guard !hasEmptyTextContainer else{
            validatedData.isValidate = false
            validatedData.errors.append(defaultErrorMsg)
            return validatedData
        }
        
        for data in validationData{
            
            let _textContainer = data.textContainer
            let _validationType = data.type
            
            
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
                
            case .phoneNo:
                let result = validatePhoneNo(in: _textContainer.textView)
                let error = "Please enter valid phone number"
                setTextContainer(toDefault: result, _textContainer,"Please enter valid phone number")
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
                let result = password == _textContainer.textView.textString ?? ""
                let error = "password not matched"
                setTextContainer(toDefault: result, _textContainer,error)
                if !result{
                    validatedData.isValidate = false
                    validatedData.errors.append(error)
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
        
        if !validatedData.errors.isEmpty{
            validatedData.commonError = defaultErrorMsg
        }
        
        return validatedData
    }
    
    private func validateEmail(in emailTextContainer:UIView)->Bool{
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: emailTextContainer.textString ?? "")
        return result
    }
    
    private func validatePhoneNo(in textContainer:UIView)->Bool{
        
        guard let text = textContainer.textString,text != "" else {return true}
        
        var formattedPN = String(text.filter{ !" \n\t\r".contains($0)})
        
        if let firtString = formattedPN.first?.description,
            firtString != " ",
            firtString == "0"{
            formattedPN.remove(at: text.startIndex)
        }
        guard let _ = Int(formattedPN) else{return false}
        guard formattedPN.count == 9 else{return false}
        return true
    }
    
}

///Types of validation options
public enum ValidationType {
    case normal
    case email
    case phoneNo
    case password
    case conformPassword
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
}

///Data returned after validate called.
public struct ValidatedData{
    public var isValidate:Bool = true
    ///All Errors array generate in validation process
    public var errors:[String] = []
    ///Return common validation error if there is more than one validation errors.
    public var commonError:String?
    
}
