
import Foundation

public protocol Response {
    
    var error: NSError? { get }
    
    func populateWithData(_ data:AnyObject?, error:NSError?)
    
}
