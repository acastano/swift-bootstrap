
import UIKit
import CoreGraphics

open class Device: NSObject {
 
    open class func registerForPushNotifications(application: UIApplication) {
        
        let types: UIUserNotificationType = [.alert, .badge, .sound]
        
        let settings = UIUserNotificationSettings(types:types, categories:nil)
        
        application.registerUserNotificationSettings(settings)
        
        application.registerForRemoteNotifications()
        
    }
    
    open class func displayName() -> String {
        
        let currentBuild = (Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String) ?? ""
        
        return currentBuild
        
    }
    
    open class func currentBuild() -> String {
        
        let currentBuild = (Bundle.main.infoDictionary?["CFBundleVersion"] as? String) ?? ""
        
        return currentBuild
        
    }
    
    open class func currentVersion() -> String {
        
        let currentVersion = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
        
        return currentVersion
        
    }
    
    open class func screenSize() -> DeviceScreenSize {
     
        var size = DeviceScreenSize.unknown
        
        let height = UIScreen.main.bounds.height
        
        switch height {
            
        case 480:
            
            size = .threeFive
            
        case 568:
            
            size = .four

        case 667:

            size = .fourSeven
            
        case 736:
            
            size = .fiveFive
            
        default :
            
            size = .unknown
            
        }
        
        return size
        
    }
    
    open class func screenHeight() -> CGFloat {
        
        return UIScreen.main.bounds.height
        
    }
    
    open class func screenWidth() -> CGFloat {
        
        return UIScreen.main.bounds.width
        
    }
    
}
