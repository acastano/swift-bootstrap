
import FoundationKit

open class HttpClientImpl: NSObject, HttpClient, URLSessionDelegate, URLSessionDataDelegate, URLSessionTaskDelegate {
    
    fileprivate var urlSession: URLSession!
    fileprivate var shouldUseSessionDelegate = false
    
    required public init(shouldUseSessionDelegate: Bool, timeout: Double) {
        
        super.init()
        
        self.shouldUseSessionDelegate = shouldUseSessionDelegate
        
        setupSession(timeout)
        
    }
    
    open func dataTask(_ requestConfiguration: RequestConfiguration, completion:@escaping DataResponseErrorCompletion) {
        
        if let url = requestConfiguration.url() {
            
            let mutableRequest = NSMutableURLRequest(url:url as URL)
            
            mutableRequest.httpMethod = requestConfiguration.method().rawValue
            
            if let headers = requestConfiguration.headers() {
                
                mutableRequest.allHTTPHeaderFields = headers
                
            }
            
            switch requestConfiguration.method() {
                
            case .GET:
                break
                
            case .POST, .DELETE, .PUT :
                
                if let contentType = requestConfiguration.headers()?[RequestHeaders.contentType.rawValue], contentType == ContentType.applicationJson.rawValue {
                    
                    mutableRequest.httpBody = requestConfiguration.dataParameters() as Data?
                    
                } else if let parameters = requestConfiguration.parameters() {
                        
                    mutableRequest.httpBody = parameters.data(using: String.Encoding.utf8)
                    
                }
                
            }
            
            let dataTask = urlSession.dataTask(with: mutableRequest as URLRequest, completionHandler:completion)
            
            dataTask.resume()
            
        } else {
            
            let error = NSError(domain:ErrorDomain.dataTask.rawValue, code:0, userInfo:nil)
            
            completion(nil, nil, error)
            
        }
        
    }
    
    open func uploadTask(_ requestConfiguration: UploadRequestConfiguration, completion:@escaping DataResponseErrorCompletion) {
        
        if let formData = requestConfiguration.formData(),
            let url = requestConfiguration.url()
            , requestConfiguration.method() == .PUT || requestConfiguration.method() == .POST {
            
            let mutableRequest = NSMutableURLRequest(url:url as URL)
            
            mutableRequest.httpMethod = requestConfiguration.method().rawValue
            
            if let headers = requestConfiguration.headers() {
                
                mutableRequest.allHTTPHeaderFields = headers
                
            }
            
            let mutableData = NSMutableData()
            
            addImageFormData(formData, mutableData:mutableData)
            
            if let dict = formData.queryFields {
                
                for (fieldName, fieldValue) in dict {
                    
                    addTextFieldFormData(mutableData, fieldValue:fieldValue, fieldName:fieldName)
                    
                }
                
            }
            
            closeForm(mutableData)
            
            mutableRequest.setValue("\(CUnsignedLong(mutableData.length))", forHTTPHeaderField:contentLength)
            
            let uploadTask: URLSessionUploadTask = urlSession.uploadTask(with: mutableRequest as URLRequest, from: mutableData as Data, completionHandler:completion)
            
            uploadTask.resume()
            
        } else {
            
            let error = NSError(domain:ErrorDomain.uploadTask.rawValue, code:0, userInfo:nil)
            
            completion(nil, nil, error)
            
        }
        
    }
    
    open func cancelRequests() {
        
        urlSession.invalidateAndCancel()
        
    }
    
    //MARK: - Helpers
    
    fileprivate func setupSession(_ timeout: Double) {
        
        let configuration = URLSessionConfiguration.default
        
        configuration.requestCachePolicy = .useProtocolCachePolicy
        
        configuration.timeoutIntervalForRequest = timeout
        
        let delegate: URLSessionDelegate? = shouldUseSessionDelegate ? self : nil
        
        urlSession = Foundation.URLSession(configuration:configuration, delegate:delegate, delegateQueue:nil)
        
    }
    
    fileprivate func addImageFormData(_ formData:MultiPartFormData, mutableData:NSMutableData) {
        
        if let data = formData.fileData {
            
            mutableData.addData(boundaryStart)
            
            let fileName = formData.fileName ?? defaultFileName
            
            let fileNameFieldData = String(format:fileNameField, fileName)
            
            mutableData.addData(fileNameFieldData.data(using: String.Encoding.utf8))
            
            mutableData.addData(contentType)
            
            mutableData.addData(data as Data)
            
            mutableData.addData(encoding)
            
            mutableData.addData(carriageReturn)
            
        }
        
    }
    
    fileprivate func addTextFieldFormData(_ mutableData:NSMutableData, fieldValue:String, fieldName:String) {
        
        mutableData.addData(boundaryStart)
        
        let fileNameFieldData = String(format:fileNameField, fieldName)
        
        mutableData.addData(fileNameFieldData.data(using: String.Encoding.utf8))
        
        let fieldData = fieldValue.data(using: String.Encoding.utf8)
        
        mutableData.addData(fieldData)
        
        mutableData.addData(carriageReturn)
        
    }
    
    fileprivate func closeForm(_ mutableData:NSMutableData) {
        
        mutableData.addData(boundaryClose)
        
    }
    
    //MARK: - NSURLSessionDelegate
    
    open func urlSession(_ session:URLSession, dataTask:URLSessionDataTask, didReceive response:URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
        completionHandler(.allow)
        
    }
    
    open func urlSession(_ session:URLSession, didReceive challenge:URLAuthenticationChallenge, completionHandler:@escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if let serverTrust = challenge.protectionSpace.serverTrust {
            
            completionHandler(.useCredential, URLCredential(trust:serverTrust))
            
        }
        
    }
    
}
