//
//  MNkTextValidatable.swift
//  MNkSupportUtilities
//
//  Created by Malith Nadeeshan on 3/25/19.
//

import Foundation

typealias ValidationData = (textContainer:MNkValidatableTextView,type:ValidationType)

public protocol MNkValidatableTextView{
    var textView:UIView{get}
    var errorBorderView:UIView?{get}
    var errorLabel:UILabel?{get}
}

extension MNkValidatableTextView{
    var errorBorderView:UIView?{
        return nil
    }
    var errorLabel:UILabel?{
        return nil
    }
}



protocol MNkTextValidatable{
    var hasEmptyTextContainer:Bool{get}
    var validationData:[ValidationData]{get set}
    var errorColor:UIColor{get}
    var defaultColor:UIColor{get}
    var textColor:UIColor{get}
    var borderColor:UIColor{get}
    var validationDisplayStyle:ValidationErrorDisplayType{get}
}

extension MNkTextValidatable{
    
    var errorColor:UIColor{
        return #colorLiteral(red: 1, green: 0.462745098, blue: 0.4588235294, alpha: 1)
    }
    var defaultColor:UIColor{
        return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    var textColor:UIColor{
        return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    var borderColor:UIColor{
        return .lightGray
    }
    
    var validationDisplayStyle:ValidationErrorDisplayType{
        return .backgroundOnly
    }
    
    //MARK:- CHECK IS THERE ANY EMPTY TEXT FIELD
    var hasEmptyTextContainer:Bool{
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
    
    func isEmpty(_ textField:MNkValidatableTextView)->Bool{
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
    
    func validate(withDefaultErrorMsg defaultErrorMsg:String = "Need to fill required fields")->Bool{
        
        var validatedData = (true,"")
        var password:String = ""
        
        var isValidate = true
        
        guard !hasEmptyTextContainer else{
//            validatedData = (false,defaultErrorMsg)
            isValidate = false
            return isValidate
        }
        
        for data in validationData{
            
            let _textContainer = data.textContainer
            let _validationType = data.type
            
            
            switch _validationType{
            case .email:
                let result = validateEmail(in:_textContainer.textView)
                setTextContainer(toDefault: result, _textContainer,"Please enter valid email")
//                guard result else{
//                    validatedData = (false,"Please enter valid email")
//                    return validatedData
//                }
                if !result{
                    isValidate = false
                }
                continue
                
            case .phoneNo:
                let result = validatePhoneNo(in: _textContainer.textView)
                setTextContainer(toDefault: result, _textContainer,"Please enter valid phone number")
//                guard result else{
//                    validatedData = (false,"Please enter valid phone number")
//                    return validatedData
//                }
                if !result{
                    isValidate = false
                }
                continue
            case .password:
                password = _textContainer.textView.textString ?? ""
                let result = password.count >= 6 ? true : false
                setTextContainer(toDefault: result, _textContainer,"The password must be 6 characters long or more")
//                guard result else{
//                    validatedData = (false,"The password must be 6 characters long or more")
//                    return validatedData
//                }
                if !result{
                    isValidate = false
                }
                continue
            case .conformPassword:
                let result = password == _textContainer.textView.textString ?? ""
                setTextContainer(toDefault: result, _textContainer,"password not matched")
//                guard password == _textContainer.textView.textString ?? "" else{
//                    validatedData = (false,"password not matched")
//                    setTextContainer(toDefault: false, _textContainer)
//                    return validatedData
//                }
                if !result{
                    isValidate = false
                }
                continue
                
            case .normal:
                let text = data.textContainer.textView.textString
                let result = text?.isEmpty ?? true
                setTextContainer(toDefault: !result, _textContainer)
                if result{
                    isValidate = false
                }
//                guard let _text = data.textContainer.textView.textString,
//                    !_text.isEmpty
//                    else{
//                        validatedData = (false,defaultErrorMsg)
//                        setTextContainer(toDefault: false, _textContainer)
//                        return validatedData
//                }
                continue
            }
        }
        
        return isValidate
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

enum ValidationType {
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


public enum ValidationErrorDisplayType{
    case backgroundOnly
    case backgroundErrorMessages
    case boderOnly
    case borderErrorMessages
}
