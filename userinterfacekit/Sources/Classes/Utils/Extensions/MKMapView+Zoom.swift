
import MapKit

private let kMaxZoom  = 20

public extension MKMapView {
    
    public func zoomLevel () -> Int {
    
        let zoomScale = CGFloat(visibleMapRect.size.width) / frame.size.width

        let zoomExponent = log2(zoomScale)
        
        let zoomLevel = kMaxZoom - Int(ceil(zoomExponent))
        
        return zoomLevel
    
    }
    
}
