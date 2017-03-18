
import Foundation

public extension Int {
    
    public func decimalString() -> String? {
        
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        
        let number = NSNumber(value: self as Int)
        
        return formatter.string(from: number)
        
    }
   
    public func spellOutString() -> String? {
        
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .spellOut
        
        let number = NSNumber(value: self as Int)
        
        return formatter.string(from: number)
        
    }

}
