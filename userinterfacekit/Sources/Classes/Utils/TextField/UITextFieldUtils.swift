
import UIKit

open class UITextFieldUtils {
    
    open class func shouldShowMaxDecimalPlaces(_ textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString: String, maxDecimalPlaces:Int) -> Bool {
        
        var shouldReturn = true
        
        if replacementString.isEmpty == false {
            
            if let input = textField.text {
                
                let numberFormatter = NumberFormatter()
                
                let inputRange = input.range(of: numberFormatter.decimalSeparator)
                
                if let range = inputRange {
                    
                    let endIndex = input.characters.index(input.startIndex, offsetBy: input.characters.distance(from: input.startIndex, to: range.upperBound))
                    
                    let decimals = input.substring(from: endIndex)
                    
                    shouldReturn = decimals.characters.count < maxDecimalPlaces
                    
                }
                
            }
            
        }
        
        return shouldReturn
        
    }
    
    open class func shouldShowMaxCharacters(_ textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString: String, maxCharacters:Int) -> Bool {
        
        var shouldReturn = true
        
        if replacementString.isEmpty == false {
            
            if let input = textField.text {
                
                let newLength = input.utf16.count + replacementString.utf16.count - range.length
                
                shouldReturn = newLength <= maxCharacters
                
            }
            
        }
        
        return shouldReturn
        
    }
    
}
