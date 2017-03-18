
import Foundation
import CoreGraphics

public extension String {
    
    public func addUKCurrency() -> String {
        
        let string = "£\(self)"
        
        return string
        
    }
    
    public func toDouble() -> Double {
        
        let number = NSString(string:self).doubleValue
        
        return number
        
    }
    
    public func decimalString() -> String? {
        
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        
        let string = NSString(format: "\(self)" as NSString)
        
        let number = string.integerValue
        
        return formatter.string(from: NSNumber(value:number))
        
    }
    
    public func yyyyMMddHHmmssDate() -> Date? {
        
        let formatter = dateFormatter("yyyy-MM-dd HH:mm:ss")
        
        let date = formatter.date(from: self)
        
        return date
        
    }
    
    public func ccccDate() -> Date? {
        
        let formatter = dateFormatter("cccc")
        
        let date = formatter.date(from: self)
        
        return date
        
    }
    
    public func yyyyMMddTHHmmssSSSZDate() -> Date? {
        
        let formatter = dateFormatter("yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        
        let date = formatter.date(from: self)
        
        return date
        
    }
    
    public func yyyyMMddTHHmmssSSSDate() -> Date? {
        
        let formatter = dateFormatter("yyyy-MM-dd'T'HH:mm:ss.SSS")
        
        let date = formatter.date(from: self)
        
        return date
        
    }
    
    public func yyyyMMddTHHmmssZDate() -> Date? {
        
        let formatter = dateFormatter("yyyy-MM-dd'T'HH:mm:ssZ")
        
        let date = formatter.date(from: self)
        
        return date
        
    }
        
    public func yyyyMM() -> Date? {
        
        let formatter = dateFormatter("yyyy-MM")
        
        let date = formatter.date(from: self)
        
        return date
        
    }
    
    public func ddmmyyyyDate() -> Date? {
        
        let formatter = dateFormatter("dd/MM/yyyy")
        
        let date = formatter.date(from: self)
        
        return date
        
    }
    
    public func yyyyMMdd() -> Date? {
        
        let formatter = dateFormatter("yyyy-MM-dd")
        
        let date = formatter.date(from: self)
        
        return date
        
    }
    
    public func lastFour() -> String {
        
        var string = self
        
        if characters.count > 4 {
        
            let index = characters.index(endIndex, offsetBy: -4)
        
            string = string.substring(from: index)
            
        }
        
        return string
        
    }
    
    public func lastTwo() -> String {
        
        var string = self
        
        if characters.count > 2 {
            
            let index = characters.index(endIndex, offsetBy: -2)
            
            string = string.substring(from: index)
            
        }
        
        return string
        
    }
    
    public func rangeOfSubstring(_ substring:String) -> NSRange? {
        
        var nsRange: NSRange?
        
        if let range = range(of: substring) {
            
            let index = characters.distance(from: startIndex, to: range.lowerBound)
        
            nsRange = NSMakeRange(index, substring.characters.count)
            
        }
        
        return nsRange
        
    }
    
    public func firstToUpper() -> String {
        
        var word = self
        
        if characters.count > 0 {
            
            let index = characters.index(startIndex, offsetBy: 1)
            
            let firstLetter = substring(to: index)
            
            let restOfWord = substring(from: index)
            
            word = firstLetter.uppercased() + restOfWord
            
        }

        return word
    
    }
    
    public func removeFirst() -> String {
        
        let index = characters.count > 0 ? 1 : 0
        
        return substring(from: characters.index(startIndex, offsetBy: index))
        
    }
    
    public func removeLast() -> String {
        
        let index = characters.count > 0 ? characters.index(before: endIndex) : endIndex
        
        return substring(to: index)
        
    }
    
    public func removeAllSpaces() -> String {
        
        let range = startIndex ..< endIndex

        return replacingOccurrences(of: " ", with:"", options:.literal, range:range)
        
    }
    
    public func base64() -> String {
        
        let plainString = self

        var base64String = ""
        
        if let plainData = plainString.data(using: String.Encoding.utf8) {
        
            base64String = plainData.base64EncodedString(options: [])
            
        }
        
        return base64String
        
    }
    
    public func stringFromBase64() -> String {
        
        var decodedString = ""
        
        if let decodedData = Data(base64Encoded:self, options:[]) {
        
            if let string = NSString(data:decodedData, encoding:String.Encoding.utf8.rawValue) as? String {
                
                decodedString = string
                
            }
            
        }

        return decodedString
        
    }
    
    public func stringByAddingPercentEncodingForURLQueryValue() -> String? {
        
        let characterSet = CharacterSet.alphanumerics
        
        return addingPercentEncoding(withAllowedCharacters: characterSet)
        
    }
    
    public func queryDictionary() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        let urlComponents = components(separatedBy: "&")
        
        for keyValuePair in urlComponents {
            
            let pairComponents = keyValuePair.components(separatedBy: "=")
            
            if let key = pairComponents.first?.removingPercentEncoding,
                let value = pairComponents.last?.removingPercentEncoding {
                    
                    dictionary.setValue(value, forKey: key)
                
            }
            
        }
        
        return dictionary
        
    }
    
    public func sizeOfString(_ attributes:[String:AnyObject], constrainedToWidth width:Double, constrainedToHeight height:Double) -> CGSize {
        
        let rect = self.boundingRect(with: CGSize(width:width, height:height), options:.usesLineFragmentOrigin, attributes:attributes, context:nil)
        
        return  rect.size
        
    }
    
    public func insert(_ string:String, atIndex:Int) -> String {
        
        if characters.count > atIndex {
            
            return  String(characters.prefix(atIndex)) + string + String(characters.suffix(characters.count - atIndex))
            
        }
        
        return self
        
    }
    
    public var isEmptyText: Bool {
        
        return trimmingCharacters(in: CharacterSet.whitespaces) == ""
        
    }
    
    public static func parameterPrefix(params: String) -> String {
        
        return params.characters.count > 0 ? "&" : ""
        
    }
    
    fileprivate func dateFormatter(_ format:String) -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        
        dateFormatter.locale = Locale(identifier:"en")
        
        return dateFormatter
        
    }
    
}
