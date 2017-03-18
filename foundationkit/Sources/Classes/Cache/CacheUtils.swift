
import Foundation

public final class Path: NSObject {
    
    public var path = ""
    private let cacheFolder = "ImageCache"
    
    override init() {
        
        let array = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        
        if array.count > 0 {
            
            var path = array[0]
            
            if let bundleIdentifier = Bundle.main.bundleIdentifier {
                
                path += "/" + bundleIdentifier + "/" + cacheFolder
                
                let fm = FileManager.default
                
                do {
                    
                    try fm.createDirectory(atPath: path, withIntermediateDirectories:true, attributes:nil)
                    
                }catch {}
                
                self.path = path
                
            }
            
        }
        
    }
    
}

public final class CacheUtils: NSObject {
    
    public class var path: Path {
        
        struct Singleton {
            
            static let instance = Path()
            
        }
        
        return Singleton.instance
        
    }
    
    public class func keyForURL(_ url:URL) -> String {
        
        let h = url.host != nil ? url.host! : ""
        let p = url.path
        let q = url.query != nil ? url.query! : ""
        
        let path = String(format:"%@%@%@", h, p, q)
        
        let doNotWant = CharacterSet(charactersIn: "/:.,")
        
        let charactersArray: [String] = path.components(separatedBy: doNotWant)
        
        let key = charactersArray.joined(separator: "")
        
        return key
        
    }
    
    public class func cleanseCache() {
        
        runOnLowPriorityQueue() {
            
            let daysToCleanCacheInSeconds: TimeInterval = 2592000
            
            let path = self.path.path
            
            let fm = FileManager.default
            
            do {
                
                let dirContents = try fm.contentsOfDirectory(atPath: path)
                
                for file in dirContents {
                    
                    let filePath = "\(path)/\(file)"
                    
                    let attr = try fm.attributesOfItem(atPath: filePath)
                    
                    if let date = attr[FileAttributeKey.modificationDate] as? Date {
                        
                        let difference = Date().timeIntervalSince(date)
                        
                        if difference > daysToCleanCacheInSeconds {
                            
                            try fm.removeItem(atPath: filePath)
                            
                        }
                        
                    }
                    
                }
                
            } catch {}
            
        }
        
    }
    
}
