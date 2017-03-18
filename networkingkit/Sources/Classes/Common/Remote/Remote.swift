
import FoundationKit

public protocol Remote {
    
    init(httpClient: HttpClient, shouldQueueResponse: Bool)
    
    func makeRequest(_ requestConfiguration: RequestConfiguration, response: Response, completion: VoidCompletion?)
    
    func makeRequestAndReturnInBackground(_ requestConfiguration:RequestConfiguration, response:Response, completion:VoidCompletion?)
    
    func makeUploadRequest(_ requestConfiguration: UploadRequestConfiguration, response: Response, completion: VoidCompletion?)
    
    func cancelRequests()
    
}
