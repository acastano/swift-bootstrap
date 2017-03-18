
import FoundationKit

public final class RemoteImpl: NSObject, Remote {
    
    fileprivate var httpClient: HttpClient
    fileprivate var shouldQueueResponse = false
    
    public required init(httpClient: HttpClient, shouldQueueResponse: Bool) {
        
        self.httpClient = httpClient
        
        self.shouldQueueResponse = shouldQueueResponse
        
    }
    
    public func makeRequest(_ requestConfiguration: RequestConfiguration, response: Response, completion: VoidCompletion?) {
        
        makeRequest(requestConfiguration, response: response, shouldReturnInBackground: false, completion: completion)
        
    }
    
    public func makeRequestAndReturnInBackground(_ requestConfiguration: RequestConfiguration, response: Response, completion: VoidCompletion?) {
        
        makeRequest(requestConfiguration, response: response, shouldReturnInBackground: true, completion: completion)
        
    }
    
    public func makeUploadRequest(_ requestConfiguration: UploadRequestConfiguration, response: Response, completion: VoidCompletion?) {
        
        httpClient.uploadTask(requestConfiguration) { (data, urlResponse, error) in
            
            let dataError = self.processResponse(data, response: urlResponse, error: error as NSError?)
            
            response.populateWithData(dataError.data, error:dataError.error)
            
            self.runOnMainThread() {
                
                completion?()
                
            }
            
        }
        
    }
    
    public func cancelRequests() {
        
        httpClient.cancelRequests();
        
    }
    
    //MARK: - Helpers
    
    fileprivate func makeRequest(_ requestConfiguration: RequestConfiguration, response: Response, shouldReturnInBackground: Bool, completion: VoidCompletion?) {
        
        httpClient.dataTask(requestConfiguration) { data, urlResponse, error in
            
            let dataTaskCompletion = {
                
                let dataError = self.processResponse(data, response: urlResponse, error: error as NSError?)
                
                response.populateWithData(dataError.data, error:dataError.error)
                
                if shouldReturnInBackground {
                    
                    completion?()
                    
                } else {
                    
                    self.runOnMainThread() {
                        
                        completion?()
                        
                    }
                    
                }
                
            }
            
            if self.shouldQueueResponse {
                
                ResponseQueue.addOperation(dataTaskCompletion)
                
            } else {
                
                dataTaskCompletion()
                
            }
            
        }
        
    }
    
    fileprivate func processResponse(_ data:Data?, response:URLResponse?, error:NSError?) -> (data: AnyObject?, error: NSError?) {
        
        var returnError = error
        
        var responseData: Any?
        
        if let data = data , error == nil {
            
            var parsingError: NSError?
            
            do {
                
                //print(NSString(data: data, encoding: String.Encoding.utf8.rawValue))
                
                responseData = try JSONSerialization.jsonObject(with: data, options:.mutableContainers)
                
                
            } catch let error as NSError {
                
                parsingError = error
                
                responseData = nil
                
            }
            
            if parsingError != nil {
                
                returnError = parsingError
                
            }
            
        }
        
        return (responseData as AnyObject?, returnError)
        
    }
    
}
