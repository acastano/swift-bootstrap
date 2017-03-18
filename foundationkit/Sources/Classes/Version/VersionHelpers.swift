
import Foundation

typealias BoolBoolBoolErrorCompletion = (Bool, Bool, Bool, NSError?) -> ()

open class VersionHelpers {
    
    open class func newAppAvailable(_ newVersion:String?, newBuild: String?) -> Bool {
        
        var new = false
        
        if let newVersion = newVersion, let newBuild = newBuild {
            
            let locale = Locale(identifier:"en_GB")
            
            let options = NSString.CompareOptions.numeric
            
            
            let currentVersion = Device.currentVersion()
            
            let isNewVersion = newVersion.compare(currentVersion, options:options, range:nil, locale:locale) == .orderedDescending
            
            new = isNewVersion
            
            if new == false && (newVersion.compare(currentVersion, options:options, range:nil, locale:locale) == .orderedSame) {
                
                let currentBuild = Device.currentBuild()
                
                let newBuild = newBuild.compare(currentBuild, options:options, range:nil, locale:locale) == .orderedDescending
                
                new = newBuild
                
            }
            
        }
        
        return new
        
    }
    
}
