
import UIKit

open class FailHitTestUIScrollView: UIScrollView {
    
    open override func hitTest(_ point:CGPoint, with event:UIEvent?) -> UIView? {
        
        var hitView = super.hitTest(point, with:event)
        
        if hitView == self {
            
            hitView = nil
            
        }
        
        return hitView
        
    }
    
}
