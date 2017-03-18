
import UIKit

public extension UIColor {

    public convenience init(netHex:Int) {
        
        self.init(red: CGFloat((netHex >> 16) & 0xff) / 255.0, green: CGFloat((netHex >> 8) & 0xff) / 255.0, blue: CGFloat(netHex & 0xff) / 255.0, alpha: 1.0)
        
    }
    
    public convenience init(netHex:Int, alpha:CGFloat) {
        
        self.init(red: CGFloat((netHex >> 16) & 0xff) / 255.0, green: CGFloat((netHex >> 8) & 0xff) / 255.0, blue: CGFloat(netHex & 0xff) / 255.0, alpha: alpha)
        
    }
    
}