
private let index0 = 0
private let index1 = 1
private let equals = "="
private let ampersand = "&"

import Foundation

public extension URL {
    
    public func queryKeyValues() -> [String:String] {
        
        var dict = [String:String]()
        
        if let keyValuesArray = query?.components(separatedBy: ampersand) {
            
            for keyValuePair in keyValuesArray {
                
                let pair = keyValuePair.components(separatedBy: equals)
                
                if let key = pair.first?.removingPercentEncoding,
                    let value = pair.last?.removingPercentEncoding {
                        
                        dict.updateValue(value, forKey: key)
                        
                }
                
            }
            
        }
        
        return dict
        
    }
    
    public func valueForQueryParameter(_ parameter:String) -> String? {
        
        var value: String?
        
        let keyValues = queryKeyValues()
        
        if keyValues.count > 0 {
            
            if let val = keyValues[parameter] {
                
                value = val
                
            }
            
        }
        
        return value
        
    }
    
}
