
import Foundation

public extension NSMutableData {
    
    public func addData(_ data: Data?) {
        
        if let dataToAppend = data {
            
            append(dataToAppend)
        }
        
    }
    
}
