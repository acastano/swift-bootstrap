
import CoreGraphics

private let kValidationWidth = CGFloat(30)

private let kLastNameRegex = "[A-Za-z ]*"
private let kFirstNameRegex = "[A-Za-z ]*"
private let kPhoneRegex = "^(\\+?)(\\d{10,12})$"
private let kPostcodeRegex = "[A-Z]{1,2}[0-9R][0-9A-Z]?[0-9]{1,2}[ABD-HJLNP-UW-Z]{1,2}"
private let kEmailRegex = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\])|(([a-zA-Z\\-0-9]+\\.)+[a-zA-Z]{2,}))$"

open class Validations: NSObject {
    
    open class func emailValidationPassed(_ view:ValidationFieldView) -> Bool {

        return regexValidationPassed(view, regex:kEmailRegex, removeSpaces:false, uppercase:false)
        
    }
    
    open class func firstNameValidationPassed(_ view:ValidationFieldView) -> Bool {
        
        return emptyValidationPassed(view)
        
    }
    
    open class func lastNameValidationPassed(_ view:ValidationFieldView) -> Bool {
        
        return emptyValidationPassed(view)
        
    }
    
    open class func matchingValidationPassed(_ view:ValidationFieldView, string: String) -> Bool {
    
        var valid = false
        
        let text = view.textField.text?.trimmingCharacters(in: CharacterSet.whitespaces)
        
        if let text = text , text.characters.count > 0, text == string {
            
            valid = true
            
            view.validationImageView.isHighlighted = false
            
        } else {
            
            view.validationImageView.isHighlighted = true
            
            view.validationWidthConstraint.constant = kValidationWidth
            
            view.leadingFieldConstraint.constant = kValidationWidth
            
        }
        
        return valid
        
    }
    
    open class func lengthValidationPassed(_ view:ValidationFieldView, minimumLength: Int) -> Bool {
     
        var valid = false
        
        let text = view.textField.text?.trimmingCharacters(in: CharacterSet.whitespaces)
        
        if let text = text , text.characters.count >= minimumLength {
            
            valid = true
            
            view.validationImageView.isHighlighted = false
            
        } else {
            
            view.validationImageView.isHighlighted = true
            
            view.validationWidthConstraint.constant = kValidationWidth
            
            view.leadingFieldConstraint.constant = kValidationWidth
            
        }
        
        return valid
        
    }
    
    open class func validationPassed(_ view:ValidationFieldView, passed:Bool) -> Bool {
        
        var valid = false
        
        if passed {
            
            valid = true
            
            view.validationImageView.isHighlighted = false
            
        } else {
            
            view.validationImageView.isHighlighted = true
            
            view.validationWidthConstraint.constant = kValidationWidth
            
            view.leadingFieldConstraint.constant = kValidationWidth
            
        }
        
        return valid
        
    }

    open class func clear(_ view:ValidationFieldView) {
        
        view.leadingFieldConstraint.constant = 0
    
        view.validationWidthConstraint.constant = 0
        
        view.validationImageView.isHighlighted = false
        
    }
    
    open class func postcodeValidationPassed(_ view:ValidationFieldView) -> Bool {
        
        return regexValidationPassed(view, regex:kPostcodeRegex, removeSpaces:true, uppercase:true)
        
    }
    
    open class func phoneValidationPassed(_ view:ValidationFieldView) -> Bool {
        
        return regexValidationPassed(view, regex:kPhoneRegex, removeSpaces:true, uppercase:false)
        
    }
    
    open class func emptyValidationPassed(_ view:ValidationFieldView) -> Bool {
        
        var valid = false
        
        let text = view.textField.text?.trimmingCharacters(in: CharacterSet.whitespaces)
        
        if let text = text , text.characters.count > 0 {
            
            valid = true
            
            view.validationImageView.isHighlighted = false
            
        } else {
            
            view.validationImageView.isHighlighted = true
            
            view.validationWidthConstraint.constant = kValidationWidth
            
            view.leadingFieldConstraint.constant = kValidationWidth
            
        }
        
        return valid
        
    }
    
    fileprivate class func regexValidationPassed(_ view:ValidationFieldView, regex:String, removeSpaces:Bool, uppercase:Bool) -> Bool {
        
        var valid = false
        
        var text = uppercase ? view.textField.text?.uppercased() : view.textField.text
        
        if removeSpaces && text != nil {
            
            let range = text!.startIndex ..< text!.endIndex
            
            text = text!.replacingOccurrences(of: " ", with:"", options:.literal, range:range)
            
        }
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray: [regex])
        
        if let string = text , string.characters.count > 0 && predicate.evaluate(with: string) {
            
            valid = true
            
            view.validationImageView.isHighlighted = false
            
        } else {
            
            view.validationWidthConstraint.constant = kValidationWidth
            
            view.leadingFieldConstraint.constant = kValidationWidth
            
            if text == nil || text?.characters.count == 0 || predicate.evaluate(with: text) == false {
                
                view.validationImageView.isHighlighted = true
                
            } else {
                
                view.validationImageView.isHighlighted = false
                
            }
            
        }
        
        return valid
        
    }

}
