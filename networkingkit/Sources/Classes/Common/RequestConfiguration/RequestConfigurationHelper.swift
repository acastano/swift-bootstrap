
import Foundation

open class RequestConfigurationHelper {

    fileprivate let port: Int?
    fileprivate let host: String?
    fileprivate let path: String?
    fileprivate let config: [String: AnyObject]?
    fileprivate let requestProtocol: RequestProtocol?
    
    public required init (config: [String: AnyObject]?) {
        
        self.config = config

        let portString = config?[RequestAttributes.port.rawValue] as? String
        
        port = portString != nil ? Int(portString!) : nil
        
        host = config?[RequestAttributes.host.rawValue] as? String
        
        path = config?[RequestAttributes.path.rawValue] as? String
        
        requestProtocol = RequestProtocol(rawValue:config?[RequestAttributes.requestProtocol.rawValue] as? String ?? RequestProtocol.http.rawValue)
        
    }
    
    open func url(_ action:String, method:RequestMethod, parameters:String?) -> URL? {
        
        var components = URLComponents()
        
        components.scheme = requestProtocol?.rawValue
        
        components.host = host
        
        if let port = port, port > 0 {
            
            components.port = port
            
        }
        
        var fullPath = "/\(action)"
        
        if let path = self.path , path.characters.count > 0 {
        
            fullPath = "\(path)/\(action)"
            
        }
        
        components.path = fullPath
        
        let count = parameters?.characters.count ?? 0
        
        if count > 0 {
            
            components.query = parameters
            
        }
        
        let url = components.url
        
        return url
        
    }
   
}
