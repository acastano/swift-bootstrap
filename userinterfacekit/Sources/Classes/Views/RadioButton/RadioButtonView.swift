
import UIKit
import CoreGraphics

@IBDesignable open class RadioButtonView: UIView {

    @IBInspectable open var selected: Bool = false {
        
        didSet {
            
            setNeedsDisplay()
 
        }
        
    }
    
    @IBInspectable open var outerColor: UIColor = UIColor.black {
        
        didSet {
            
            setNeedsDisplay()
            
        }
        
    }
    
    @IBInspectable open var innerColor: UIColor = UIColor.black {
        
        didSet {
            
            setNeedsDisplay()
            
        }
        
    }
    
    fileprivate let innerCircleRadius = CGFloat(7)
    fileprivate let outerCircleRadius = CGFloat(12)

    override open func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        if selected {

            drawSelectedState()
            
        }else {
            
            drawUnSelectedState()
            
        }
        
    }
    
    fileprivate func drawUnSelectedState() {
    
        drawOuterCircle()
    
    }
    
    fileprivate func drawSelectedState() {
        
        drawOuterCircle()
        
        drawInnerCircle()
        
    }
    
    fileprivate func drawOuterCircle() {
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.setLineWidth(1.0)
        
        outerColor.set()
        
        context?.addArc(center: CGPoint(x:frame.size.width / 2, y: frame.size.height / 2), radius: outerCircleRadius, startAngle: 0.0, endAngle: CGFloat(.pi * 2.0), clockwise: true)
        
        context?.strokePath()
        
    }
    
    fileprivate func drawInnerCircle() {
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(innerColor.cgColor)
        
        context?.addArc(center: CGPoint(x:frame.size.width / 2, y: frame.size.height / 2), radius: innerCircleRadius, startAngle: 0.0, endAngle: CGFloat(.pi * 2.0), clockwise: true)

        context?.fillPath()
                
    }

}
