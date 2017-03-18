
import UIKit

open class FailHitTestImageView: UIImageView {

    open override func hitTest(_ point:CGPoint, with event:UIEvent?) -> UIView? {
        
        var hitView = super.hitTest(point, with:event)
        
        if hitView == self {
            
            hitView = nil
            
        }
                
        return hitView
        
    }
 
}
