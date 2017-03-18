
import UIKit

public extension UICollectionView {
    
    public var centerPoint: CGPoint {
        
        get {
            
            return CGPoint(x:center.x + contentOffset.x, y:center.y + contentOffset.y)
            
        }
        
    }
    
    public var centerCellIndexPath: IndexPath? {
        
        var indexPath: IndexPath?
        
        if let centerIndexPath = indexPathForItem(at: centerPoint) {
            
            indexPath = centerIndexPath
            
        }
        
        return indexPath

    }
    
}
