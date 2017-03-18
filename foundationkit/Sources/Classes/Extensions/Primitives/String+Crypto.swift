
import Foundation
import CommonCrypto

public extension String {
    
    public func sha1() -> String? {
        
        var output: NSMutableString?
        
        if let data = dataUsingEncoding(NSUTF8StringEncoding) {
        
            var digest = [UInt8](count:Int(CC_SHA1_DIGEST_LENGTH), repeatedValue:0)
            
            CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
            
            output = NSMutableString(capacity:Int(CC_SHA1_DIGEST_LENGTH))
            
            for byte in digest {
                
                output?.appendFormat("%02x", byte)
                
            }
            
        }
        
        var string: String?
        
        if let output = output {
            
            string = String(output)
            
        }
        
        return string
        
    }
    
    public func applyHmac(key: String) -> String? {
        
        return ""
        
    }
    
    public func hmac(key: String) -> String? {

        var hmac: String?
        
        if let cData = cStringUsingEncoding(NSUTF8StringEncoding), let cKey = key.cStringUsingEncoding(NSUTF8StringEncoding) {
            
            let digestLenght = Int(CC_SHA1_DIGEST_LENGTH)
            
            let cHMAC = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLenght)
            
            CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), cKey, Int(strlen(cKey)), cData, Int(strlen(cData)), cHMAC)
            
            let hash = NSMutableString()

            for i in 0..<digestLenght {
                
                hash.appendFormat("%02x", cHMAC[i])
                
            }
            
            hmac = String(hash)
            
        }
        
        return hmac
        
    }
    
}
