
import Security
import Foundation

public final class Keychain: NSObject {
    
    fileprivate let identifier: String?
    fileprivate let accessGroup: String?
    
    public init(identifier:String, accessGroup:String?) {
        
        self.identifier = identifier
        
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            
            self.accessGroup = nil
            
        #else
            
            self.accessGroup = accessGroup
            
        #endif
        
    }
    
    public init(identifier:String) {
        
        self.identifier = identifier
        
        self.accessGroup = nil
        
    }
    
    public func getString(_ key:String) -> String? {
        
        var value: String?
        
        if let data = getData(key) {
            
            value = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as? String
            
        }
        
        return value
        
    }
    
    public func setString(_ key:String, value:String) -> Bool {
        
        var success = false
        
        if let data = value.data(using: String.Encoding.utf8) {
            
            success = set(key, value: data)
            
        }
        
        return success
        
    }
    
    public func getData(_ key:String) -> Data? {
        
        var query = keychainQueryGet()
        
        query[kSecAttrAccount as String] = key as AnyObject?
        
        var data: Data? = nil
        
        var dataTypeRef: AnyObject?
        
        let status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        
        if status == noErr {
            
            data = dataTypeRef as? Data
            
        }
        
        return data
        
    }
    
    public func set(_ key:String, value:Data) -> Bool {
        
        _ = deleteKey(key)
        
        var query = keychainAccesibleQuery()
        
        query[kSecAttrAccount as String] = key as AnyObject?
        
        query[kSecValueData as String] = value as AnyObject?
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        let success = status == noErr
        
        return success
        
    }
    
    public func deleteKey(_ key:String) -> Bool {
        
        var query = keychainQuery()
        
        query[kSecAttrAccount as String] = key as AnyObject?
        
        let status = SecItemDelete(query as CFDictionary)
        
        let sucess = status == noErr
        
        return sucess
        
    }
    
    public func clear() -> Bool {
        
        let query = keychainQuery()
        
        let status = SecItemDelete(query as CFDictionary)
        
        let success = status == noErr
        
        return success
        
    }
    
    fileprivate func keychainQueryGet() -> [String:AnyObject] {
        
        var query = keychainAccesibleQuery()
        
        query[kSecReturnData as String] = kCFBooleanTrue
        
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        
        return query
        
    }
    
    fileprivate func keychainAccesibleQuery() -> [String:AnyObject]  {
        
        var query = keychainQuery()
        
        query[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        
        return query
        
    }
    
    fileprivate func keychainQuery() -> [String:AnyObject]  {
        
        var query = [String:AnyObject]()
        
        if let identifier = identifier {
            
            query[kSecAttrService as String] = identifier as AnyObject?
            query[kSecAttrGeneric as String] = identifier as AnyObject?
            
        }
        
        if let accessGroup = accessGroup {
            
            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
            
        }
        
        query[kSecClass as String] = kSecClassGenericPassword
        
        return query
        
    }
    
}
