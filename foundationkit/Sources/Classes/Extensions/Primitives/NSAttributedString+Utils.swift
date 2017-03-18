
import UIKit

extension NSMutableAttributedString {
    
    open func setAsLink(_ textToFind:String, linkURL:String) -> Bool {
        
        let foundRange = mutableString.range(of: textToFind)
        
        if foundRange.location != NSNotFound, let url = URL(string:linkURL) {
            
            addAttribute(NSLinkAttributeName, value:url, range:foundRange)
            
            return true
            
        }
        
        return false
        
    }
    
    open func setAsUnderline(_ textToFind:String, color:UIColor) {
        
        let foundRange = mutableString.range(of: textToFind)
        
        if foundRange.location != NSNotFound {
            
            let attributes = [NSForegroundColorAttributeName:color, NSUnderlineStyleAttributeName:NSUnderlineStyle.styleSingle.rawValue] as [String : Any]
            
            addAttributes(attributes, range:foundRange)
            
        }
        
    }
    
    open func setAsBold(_ textToFind: String) -> Bool {
        
        let foundRange = mutableString.range(of: textToFind)
        
        if foundRange.location != NSNotFound {
            
            addAttribute(NSFontAttributeName, value: UIFont.boldSystemFont(ofSize: 12.0), range: foundRange)
            
            return true
            
        }
        
        return false
        
    }
    
}
