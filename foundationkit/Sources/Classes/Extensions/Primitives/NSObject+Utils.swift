    
import Foundation

public extension NSObject {
    
    public class func className() -> String {
        
        return NSStringFromClass(self)
        
    }
    
    public class func shortClassName() -> String {
        
        let name = String(describing: self)
        
        return name
        
    }
    
    public func shortClassName() -> String {
        
        let name = String(describing: self)
        
        return name
        
    }
    
    public class func count(_ string:String) -> Int {
        
        return string.characters.count
        
    }
    
    public func count(_ string:String) -> Int {
        
        return string.characters.count
        
    }
    
    public func dictionaryFromJSONFile(_ name:String, bundle:Bundle) -> Any? {
        
        var responseData: Any?
        
        let path = bundle.url(forResource:name, withExtension:nil)
        
        if let path = path, let data = try? Data(contentsOf: path) {
            
            do {
                
                responseData = try JSONSerialization.jsonObject(with: data, options:.mutableContainers)
                
            } catch {}
            
        }
        
        return  responseData
        
    }

}

