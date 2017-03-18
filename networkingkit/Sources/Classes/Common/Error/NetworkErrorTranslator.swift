
import UIKit
import Foundation
import FoundationKit

open class NetworkErrorTranslator: NSObject, ErrorTranslator {
    
    open func imageForError(_ error:NSError?) -> UIImage? {
        
        var image: UIImage?
        
        if let error = error {
            
            switch error.code {
                
            case NSURLErrorNotConnectedToInternet:
                
                image = UIImage(named:"no-connection-icon")
                
                break
                
            default:
                break
                
            }
            
        }
        
        return image
        
    }
    
    open func localizedTitleForError(_ error:NSError?) -> String? {
        
        var stringError = NSLocalizedString("Error", comment:"")
        
        if let error = error {
            
            switch error.code {
                
            case NSURLErrorNotConnectedToInternet:
                
                stringError = NSLocalizedString("No Connection", comment:"")
                
                break
                
            default:
                break
                
            }
            
        }
        
        return stringError
        
    }
    
    open func localizedMessageForError(_ error:NSError?) -> String? {
        
        var stringError = NSLocalizedString("An error has occurred, please try again later", comment:"")
        
        if let error = error {
            
            switch error.code {
                
            case NSURLErrorNotConnectedToInternet:
                
                stringError = NSLocalizedString("You must be online for that!", comment:"")
                
            default:
                break
                
            }
            
        }
        
        return stringError
        
    }
    
}
