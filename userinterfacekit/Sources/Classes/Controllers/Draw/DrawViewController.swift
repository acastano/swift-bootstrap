
import UIKit

public final class DrawViewController: ViewController {
    
    fileprivate var red = CGFloat(0)
    fileprivate var blue = CGFloat(0)
    fileprivate var green = CGFloat(0)
    fileprivate var brush = CGFloat(4)
    fileprivate var mouseSwiped = false
    fileprivate var opacity = CGFloat(1)
    fileprivate var lastPoint = CGPoint.zero
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var tempDrawImage: UIImageView!
    
    //MARK - Actions
    
    public func image() -> UIImage? {
        
        return mainImage?.image
        
    }
    
    public func reset() {
        
        mainImage?.image = nil
        
    }
    
    //MARK - Touches
    
    public override func touchesBegan(_ touches:Set<UITouch>, with event:UIEvent?) {
        
        super.touchesBegan(touches, with:event)
        
        mouseSwiped = false
        
        let touch = touches.first
        
        lastPoint = touch?.location(in: view) ?? CGPoint.zero
        
    }
    
    public override func touchesMoved(_ touches:Set<UITouch>, with event:UIEvent?) {
        
        super.touchesMoved(touches, with:event)
        
        mouseSwiped = true
        
        if let touch = touches.first {
            
            let currentPoint = touch.location(in: view)
            
            UIGraphicsBeginImageContext(view.frame.size)
            
            tempDrawImage.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
            
            UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
            
            UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currentPoint.x, y: currentPoint.y))
            
            UIGraphicsGetCurrentContext()?.setLineCap(.round)
            
            UIGraphicsGetCurrentContext()?.setLineWidth(brush)
            
            UIGraphicsGetCurrentContext()?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
            
            UIGraphicsGetCurrentContext()?.setBlendMode(.normal)
            
            UIGraphicsGetCurrentContext()?.strokePath()
            
            tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext()
            
            tempDrawImage.alpha = opacity
            
            UIGraphicsEndImageContext();
            
            lastPoint = currentPoint;
            
        }
        
    }
    
    
    public override func touchesEnded(_ touches:Set<UITouch>, with event:UIEvent?) {
        
        super.touchesEnded(touches, with:event)
        
        if mouseSwiped == false {
            
            UIGraphicsBeginImageContext(view.frame.size)
            
            tempDrawImage.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
            
            UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
            
            UIGraphicsGetCurrentContext()?.setLineWidth(brush)
            
            UIGraphicsGetCurrentContext()?.setStrokeColor(red: red, green: green, blue: blue, alpha: opacity)
            
            UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
            
            UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
            
            UIGraphicsGetCurrentContext()?.strokePath()
            
            UIGraphicsGetCurrentContext()?.flush()
            
            tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
        }
        
        UIGraphicsBeginImageContext(mainImage.frame.size)
        
        mainImage.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode:.normal, alpha:1.0)
        
        tempDrawImage.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode:.normal, alpha:opacity)
        
        mainImage.image = UIGraphicsGetImageFromCurrentImageContext()
        
        tempDrawImage.image = nil
        
        UIGraphicsEndImageContext()
        
    }
    
}

