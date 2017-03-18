
import FoundationKit

public typealias DataResponseErrorCompletion = (_ data:Data?, _ response:URLResponse?, _ error:Error?) -> ()

public protocol HttpClient {
    
    init(shouldUseSessionDelegate: Bool, timeout: Double)
        
    func dataTask(_ requestConfiguration: RequestConfiguration, completion:@escaping DataResponseErrorCompletion)
    
    func uploadTask(_ requestConfiguration: UploadRequestConfiguration, completion:@escaping DataResponseErrorCompletion)
    
    func cancelRequests()
    
}
