
import UIKit

open class RangeSlider: UIControl {

    open var lowerValue: Double = 0.0 {
        
        didSet {
            
            updatePositions()
            
        }
        
    }
    
    open var upperValue: Double = 1.0 {
        
        didSet {
            
            updatePositions()
            
        }
        
    }

    open var thumbWidth = CGFloat(0)
    open var previousLocation = CGPoint.zero
   
    fileprivate let minimumValue = Double(0.0)
    fileprivate let maximumValue = Double(1.0)
    
    @IBOutlet open weak var minImageView: UIImageView!
    @IBOutlet open weak var maxImageView: UIImageView!
    @IBOutlet open weak var minXConstraint: NSLayoutConstraint!
    @IBOutlet open weak var maxXConstraint: NSLayoutConstraint!
    
    open override func awakeFromNib() {
        
        super.awakeFromNib()
        
        thumbWidth = minImageView.frame.width
        
    }

    open override func beginTracking(_ touch:UITouch, with event:UIEvent?) -> Bool {
        
        super.beginTracking(touch, with:event)
        
        previousLocation = touch.location(in: self)
        
        if maxImageView.frame.contains(previousLocation) {
            
            bringSubview(toFront: maxImageView)

            maxImageView.isHighlighted = true
            
        }else if minImageView.frame.contains(previousLocation) {

            bringSubview(toFront: minImageView)

            minImageView.isHighlighted = true
            
        }
        
        return minImageView.isHighlighted || maxImageView.isHighlighted
        
    }

    open override func continueTracking(_ touch:UITouch, with event:UIEvent?) -> Bool {
        
        super.continueTracking(touch, with:event)
        
        let location = touch.location(in: self)
        
        let deltaLocation = Double(location.x - previousLocation.x)

        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - thumbWidth)
        
        previousLocation = location
        
        if maxImageView.isHighlighted {
            
            let upperValueWithDelta = upperValue + deltaValue
            
            let futureUpperValue = boundValue(upperValueWithDelta, toLowerValue:lowerValue, upperValue:maximumValue)
            
            if shouldUpdatePosition(lowerValue, upperValue:futureUpperValue) {
                
                upperValue = futureUpperValue
                
            }
            
        } else if minImageView.isHighlighted {
            
            let lowerValueWithDelta = lowerValue + deltaValue
            
            let futureLowerValue = boundValue(lowerValueWithDelta, toLowerValue:minimumValue, upperValue:upperValue)
            
            if shouldUpdatePosition(futureLowerValue, upperValue:upperValue) {

                lowerValue = futureLowerValue
                
            }
            
        }
        
        updatePositions()
        
        sendActions(for: .valueChanged)
        
        return true
        
    }
    
    open override func endTracking(_ touch:UITouch?, with event:UIEvent?) {
        
        super.endTracking(touch, with:event)
        
        minImageView.isHighlighted = false
        
        maxImageView.isHighlighted = false
        
    }
    
    fileprivate func boundValue(_ value:Double, toLowerValue lowerValue:Double, upperValue:Double) -> Double {
        
        return min(max(value, lowerValue), upperValue)
        
    }
    
    fileprivate func shouldUpdatePosition(_ lowerValue:Double, upperValue:Double) -> Bool {
        
        var shouldUpdate = false
        
        let lowerThumbCenter = CGFloat(positionForValue(lowerValue))
        
        let lowerThumbX = lowerThumbCenter - thumbWidth / 2.0
        
        
        let upperThumbCenter = CGFloat(positionForValue(upperValue))
        
        let upperThumbX = upperThumbCenter - thumbWidth / 2.0
        
        
        shouldUpdate = lowerThumbX + thumbWidth < upperThumbX || upperThumbX - thumbWidth > lowerThumbX
            
        return shouldUpdate
        
    }
    
    fileprivate func updatePositions() {
        
        let lowerThumbCenter = CGFloat(positionForValue(lowerValue))
        
        let lowerThumbX = lowerThumbCenter - thumbWidth / 2.0
        

        let upperThumbCenter = CGFloat(positionForValue(upperValue))
        
        let upperThumbX = upperThumbCenter - thumbWidth / 2.0
        
        minXConstraint.constant = lowerThumbX

        maxXConstraint.constant = upperThumbX
        
    }
    
    fileprivate func positionForValue(_ value:Double) -> Double {
       
        let numerator = Double(bounds.width - thumbWidth) * (value - minimumValue)
        
        let denominator = (maximumValue - minimumValue) + Double(thumbWidth / 2.0)
        
        return numerator / denominator
        
    }
    
}
