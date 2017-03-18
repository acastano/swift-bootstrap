
import Foundation

open class XMLParser: NSObject, XMLParserDelegate {
    
    fileprivate var error: NSError?
    fileprivate var stack: NSMutableArray!
    fileprivate var currentString: NSMutableString!
    
    open func dictionaryWithContentsOfData(_ data:Data, completion:(NSDictionary?, NSError?) -> ()) {
        
        stack = NSMutableArray()
        
        let rootDictionary = NSMutableDictionary()
        
        stack.add(rootDictionary)
        
        currentString = NSMutableString()
        
        let parser = Foundation.XMLParser(data: data)
        
        parser.delegate = self
        
        let success = parser.parse()
        
        let dictionary = success ? stack.lastObject as? NSDictionary : nil
        
        completion(dictionary, error)
        
    }
    
    fileprivate func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    
        if let parentDict = stack.lastObject as? NSMutableDictionary {
            
            let childDict = NSMutableDictionary(dictionary:attributeDict)
            
            let existingValue: AnyObject? = parentDict.object(forKey: elementName) as AnyObject?
            
            if existingValue != nil {
                
                var array: NSMutableArray?
                
                if existingValue is NSMutableArray {
                    
                    array = existingValue as? NSMutableArray
                    
                } else {
                    
                    array = NSMutableArray()
                    
                    array!.add(existingValue!)
                    
                    parentDict.setObject(array!, forKey:elementName as NSCopying)
                    
                }
                
                array?.add(childDict)
                
            } else {
                
                parentDict.setObject(childDict, forKey:elementName as NSCopying)
                
            }
            
            stack.add(childDict)
            
        }
        
    }
    
    fileprivate func parser(_ parser:XMLParser, didEndElement elementName:String, namespaceURI:String?, qualifiedName qName:String?) {
        
        stack.removeLastObject()
        
        let string = currentString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if string.characters.count > 0 {
            
            if let dict = stack.lastObject as? NSMutableDictionary {
                
                dict.setObject(string, forKey:elementName as NSCopying)
                
            }
            
            currentString = NSMutableString()
            
        }
        
    }
    
    fileprivate func parser(_ parser:XMLParser, foundCharacters string:String) {
        
        currentString.append(string)
        
    }
    
    fileprivate func parser(_ parser:XMLParser, parseErrorOccurred parseError:Error) {
        
        error = parseError as NSError?
        
    }
    
}
