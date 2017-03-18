
import UIKit

open class SingleSlider: UIControl {

    var value: Double = 0.0 {
        
        didSet {
            
            updatePositions()
            
        }
        
    }
    
    open var thumbWidth = CGFloat(0)
    open var previousLocation = CGPoint.zero
   
    fileprivate let minimumValue = Double(0.0)
    fileprivate let maximumValue = Double(1.0)
    
    @IBOutlet open weak var valueLabel: UILabel!
    @IBOutlet open weak var minImageView: UIImageView!
    @IBOutlet open weak var minXConstraint: NSLayoutConstraint!
    
    open override func awakeFromNib() {
        
        super.awakeFromNib()
        
        thumbWidth = minImageView.frame.width
        
    }

    open override func beginTracking(_ touch:UITouch, with event:UIEvent?) -> Bool {
        
        super.beginTracking(touch, with:event)
        
        previousLocation = touch.location(in: self)
        
        if minImageView.frame.contains(previousLocation) {

            minImageView.isHighlighted = true
            
        }
        
        return minImageView.isHighlighted
        
    }

    open override func continueTracking(_ touch:UITouch, with event:UIEvent?) -> Bool {
        
        super.continueTracking(touch, with:event)
        
        let location = touch.location(in: self)
        
        let deltaLocation = Double(location.x - previousLocation.x)

        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - thumbWidth)
        
        previousLocation = location
        
        if minImageView.isHighlighted {
            
            let lowerValueWithDelta = value + deltaValue
            
            let futureLowerValue = boundValue(lowerValueWithDelta, toLowerValue:minimumValue, upperValue:maximumValue)
            
            value = futureLowerValue
            
        }
        
        updatePositions()
        
        sendActions(for: .valueChanged)
        
        return true
        
    }
    
    open override func endTracking(_ touch:UITouch?, with event:UIEvent?) {
        
        super.endTracking(touch, with:event)
        
        minImageView.isHighlighted = false
        
    }
    
    fileprivate func boundValue(_ value:Double, toLowerValue lowerValue:Double, upperValue:Double) -> Double {
        
        return min(max(value, lowerValue), upperValue)
        
    }
    
    fileprivate func updatePositions() {
        
        let thumbCenter = CGFloat(positionForValue(value))
        
        let thumbX = thumbCenter - thumbWidth / 2.0
        
        minXConstraint.constant = thumbX
        
    }
    
    fileprivate func positionForValue(_ value:Double) -> Double {
       
        let numerator = Double(bounds.width - thumbWidth) * (value - minimumValue)
        
        let denominator = (maximumValue - minimumValue) + Double(thumbWidth / 2.0)
        
        return numerator / denominator
        
    }
    
}
