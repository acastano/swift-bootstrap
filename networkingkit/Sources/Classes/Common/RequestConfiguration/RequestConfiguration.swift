
import Foundation

public protocol RequestConfiguration {
    
    func url() -> URL?
    
    func action() -> String
    
    func parameters() -> String?
    
    func method() -> RequestMethod
    
    func dataParameters() -> Data?
    
    func headers() -> [String: String]?
        
}
