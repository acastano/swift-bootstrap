
import UIKit
import FoundationKit

extension UIStoryboard {
    
    public func instantiateViewController<T:ViewController>() -> T {
        
        let name = T.shortClassName()

        let controller = self.instantiateViewController(withIdentifier: name) as! T
        
        return controller
        
    }
    
    public class func instantiateViewController<T:ViewController>() -> T {
        
        let name = T.shortClassName()
        
        let bundle = Bundle(for:T.self)

        let storyboard = UIStoryboard(name:name, bundle:bundle)

        let controller = storyboard.instantiateViewController(withIdentifier: name) as! T
        
        return controller
        
    }
    
    public class func instantiateViewController<T:ViewController>(_ identifier:String) -> T {
        
        let name = T.shortClassName()
        
        let bundle = Bundle(for:T.self)

        let storyboard = UIStoryboard(name:name, bundle:bundle)
        
        let controller = storyboard.instantiateViewController(withIdentifier: identifier) as! T
        
        return controller
        
    }
    
}
