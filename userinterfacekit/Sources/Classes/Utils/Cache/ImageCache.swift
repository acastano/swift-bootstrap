
import UIKit
import Foundation
import FoundationKit

public final class ImageCache: NSObject, URLSessionDelegate {
    
    private let lock = NSLock()
    private let queue = OperationQueue()
    private let fileManager = FileManager.default
    private let downloadingURLs = NSMutableDictionary()
    private let memCache = NSCache<AnyObject, UIImage>()
    private let configuration = URLSessionConfiguration.default
    
    public typealias ImageCompletion = (_ image:UIImage?, _ url:URL) -> ()
    
    public class var imageCache: ImageCache {
        
        struct Static {
            
            static let instance = ImageCache()
            
        }
        
        return Static.instance
        
    }
    
    override init() {
        
        super.init()
        
        queue.maxConcurrentOperationCount = 100
        
        NotificationCenter.default.addObserver(self, selector:#selector(ImageCache.removeAll(notification:)), name:NSNotification.Name.UIApplicationDidReceiveMemoryWarning, object:nil)
        
    }
    
    internal func removeAll(notification: NSNotification) {
        
        memCache.removeAllObjects()
        
    }
    
    //MARK: - Methods
    
    public func saveImageInCache(_ image:UIImage, url:URL) {
        
        let data = UIImagePNGRepresentation(image)
        
        let absoluteURL = url.absoluteString
        
        let path = filePath(absoluteURL)
        
        try? data?.write(to: URL(fileURLWithPath: path), options: [])
        
    }
    
    public func loadImageWithURL(_ url:URL, completion:ImageCompletion?) {
        
        let path = filePath(url.absoluteString)
        
        if let image = localImage(path) {
            
            completion?(image, url)
            
        } else {
            
            operationExecution(url, path:path, completion:completion)
            
        }
        
    }
    
    public func loadImageFromDiskWithURLString(_ urlString:String?) -> UIImage? {
        
        var image: UIImage?
        
        if let urlString = urlString, let url = URL(string:urlString) {
            
            let path = filePath(url.absoluteString)
            
            image = localImage(path)
            
        }
        
        return image
        
    }
    
    public func loadImageFromDiskWithURL(_ url:URL?) -> UIImage? {
        
        var image: UIImage?
        
        if let url = url {
            
            let path = filePath(url.absoluteString)
            
            image = localImage(path)
            
        }
        
        return image
        
    }
    
    func cancelImageForURL(_ url:URL) {
        
        runInBackground() { [weak self] in
            
            if let instance = self {
                
                instance.lock.lock()
                
                let absoluteURL = url.absoluteString
                
                if let operation = instance.downloadingURLs[absoluteURL] as? BlockOperation {
                    
                    operation.cancel()
                    
                }
                
                instance.downloadingURLs.removeObject(forKey: absoluteURL)
                
                instance.lock.unlock()
                
            }
            
        }
        
    }
    
    public func removeImageWithURL(_ url:URL) {
        
        let url = url.absoluteString
        
        let path = filePath(url)
        
        removePath(path)
        
    }
    
    func removeImageInCacheForKey(_ key:String) {
        
        let path = CacheUtils.path.path + "/" + key
        
        removePath(path)
        
    }
    
    //MARK: - Operation
    
    private func operationExecution(_ url:URL, path:String, completion:ImageCompletion?) {
        
        let operation = BlockOperation()
        
        operation.addExecutionBlock { [weak self] in
            
            if let instance = self {
                
                instance.processRemoteOperation(operation, url:url, path:path, completion:completion)
                
            }
            
        }
        
        lock.lock()
        
        downloadingURLs[path] = operation
        
        queue.addOperation(operation)
        
        lock.unlock()
        
    }
    
    private func processRemoteOperation(_ operation: Operation, url:URL, path:String, completion:ImageCompletion?) {
        
        remoteData(url, path:path) { data in
            
            if operation.isCancelled == false {
                
                self.lock.lock()
                
                var image: UIImage?
                
                if let data = data {
                    
                    image = self.imageWithData(data, removeIfInvalid:path)
                    
                }
                
                self.runOnMainThread() {
                    
                    completion?(image, url)
                    
                }
                
                self.downloadingURLs.removeObject(forKey: path)
                
                self.lock.unlock()
                
            }
            
        }
        
    }
    
    //MARK: - Helpers
    
    private func filePath(_ urlString:String?) -> String {
        
        var filePath = CacheUtils.path.path
        
        if let urlString = urlString, let url = URL(string:urlString) {
            
            filePath = filePath + "/" + CacheUtils.keyForURL(url)
            
        }
        
        return filePath
        
    }
    
    //MARK: - Data
    
    private func localDataFromDisk(_ path:String) -> Data? {
        
        var data: Data?
        
        let attributes = [FileAttributeKey.modificationDate:Date()]
        
        try? fileManager.setAttributes(attributes, ofItemAtPath:path)
        
        let url = URL(fileURLWithPath: path)
        
        data = try? Data(contentsOf:url , options:.mappedIfSafe)
        
        return data
        
    }
    
    private func remoteData(_ url:URL, path:String, completion:@escaping ((Data?) -> Void)) {
        
        let session = Foundation.URLSession(configuration: configuration, delegate:self, delegateQueue:nil)
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            try? data?.write(to: URL(fileURLWithPath: path), options: [])
            
            completion(data)
            
        })
        
        task.resume()
        
    }
    
    private func localImage(_ path:String) -> UIImage? {
        
        var image = memCache.object(forKey: path as AnyObject)
        
        if image == nil, let data = localDataFromDisk(path) {
            
            image = imageWithData(data, removeIfInvalid:path)
            
            if let image = image {
            
                memCache.setObject(image, forKey: path as AnyObject, cost: data.count)
                
            }

        }
        
        return image
        
    }
    
    private func removePath(_ path:String) {
        
        if fileManager.fileExists(atPath: path) {
            
            try? fileManager.removeItem(atPath: path)
            
        }
        
    }
    
    private func imageWithData(_ data:Data, removeIfInvalid path:String) -> UIImage? {
        
        var image = UIImage(data:data)
        
        if image != nil {
            
            image = image?.withRenderingMode(.alwaysOriginal)
            
        } else {
            
            try? fileManager.removeItem(atPath: path)
            
        }
        
        return image
        
    }
    
    //MARK: - NSURLSessionDelegate
    
    func URLSession(_ session:Foundation.URLSession, dataTask:URLSessionDataTask, didReceiveResponse response:URLResponse, completionHandler: (Foundation.URLSession.ResponseDisposition) -> Void) {
        
        completionHandler(.allow)
        
    }
    
    public func urlSession(_ session:URLSession, didReceive challenge:URLAuthenticationChallenge, completionHandler:@escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if let serverTrust = challenge.protectionSpace.serverTrust {
            
            completionHandler(.useCredential, URLCredential(trust:serverTrust))
            
        }
        
    }
    
}
