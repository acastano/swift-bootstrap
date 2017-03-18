
import Foundation

open class PNSHelpers {
    
    open class func registerForPushNotifications() {
        
        let types: UIUserNotificationType = [.alert, .badge, .sound]
        
        let settings = UIUserNotificationSettings(types:types, categories:nil)
        
        UIApplication.shared.registerUserNotificationSettings(settings)
        
        UIApplication.shared.registerForRemoteNotifications()
        
    }
    
}
