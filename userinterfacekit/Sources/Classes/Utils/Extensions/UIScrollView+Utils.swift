
import UIKit

public enum ScrollViewDirection {
    
    case up
    case down
    case left
    case right
    case undetermined
    
}

public extension UIScrollView {
    
    public func verticalDirection() -> ScrollViewDirection {
        
        var direction = ScrollViewDirection.undetermined
        
        if panGestureRecognizer.velocity(in: self).y > 0 {
            
            direction = .up
            
        } else if panGestureRecognizer.velocity(in: self).y < 0 {
            
            direction = .down
            
        }
        
        return direction
        
    }
    
    public func horizontalDirection() -> ScrollViewDirection {
        
        var direction = ScrollViewDirection.undetermined
        
        if panGestureRecognizer.velocity(in: self).x > 0 {
            
            direction = .left
            
        } else if panGestureRecognizer.velocity(in: self).x < 0 {
            
            direction = .right
            
        }
        
        return direction
        
    }
    
}
