
import Foundation

private let kFirstKeyIndex = 0
private let  kSecondKeyIndex = 1

open class JSONValueExtractor {
    
    open class func valueForKeyPath(_ keyPath: String, data:[String:AnyObject]?) -> AnyObject? {
    
        let keys = keyPath.characters.split {$0 == "."} .map(String.init)
        
        let value = valueWithKeyPaths(keys, data:data as AnyObject?)
        
        return value
        
    }

    class func valueWithKeyPaths(_ keys:[String], data:AnyObject?) -> AnyObject? {
     
        var result: AnyObject?
        
        var keysToRemove = 0
        
        if let data = data as? [String:AnyObject] {
            
            if keys.count > 0 {
                
                keysToRemove = 1
                
                let key = keys[kFirstKeyIndex];
                
                result = data[key]
                
            }
            
        } else if let data = data as? [[String:AnyObject]] {
            
            if  keys.count > 1 {
                
                keysToRemove = 2
                
                let key = keys[kFirstKeyIndex]
                
                let value = keys[kSecondKeyIndex]
                
                result = valueForArray(data, key:key, value:value)
                
            }
            
        }
        
        if keys.count == keysToRemove || data == nil {
            
            return result
            
        } else {
            
            let newKeys = Array(keys[keysToRemove...keys.count - 1])
            
            return valueWithKeyPaths(newKeys, data:result)
            
        }
        
    }
    
    class func valueForArray(_ array:[[String:AnyObject]], key: String, value:String) -> AnyObject? {
        
        let results = array.filter() { let result = $0[key] as? String; return result == value; }
            
        return results.first as AnyObject?
        
    }
    
}
