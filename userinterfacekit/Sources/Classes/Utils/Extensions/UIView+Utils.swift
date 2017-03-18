
import UIKit

public extension UIView {
    
    public func applyGradient(_ colors:[UIColor]) {
        
        let gradientLayer = createLayer(colors)
        
        layer.mask = gradientLayer
        
    }
    
    public func insertGradient(_ colors: [UIColor], below view: UIView) -> CAGradientLayer {
        
        let gradientLayer = createLayer(colors)
        
        layer.insertSublayer(gradientLayer, below: view.layer)
     
        return gradientLayer
        
    }
    
    public func snapshot() -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: frame, afterScreenUpdates:false)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
        
    }
    
    public class func loadFromNibNamed(_ nibNamed:String, bundle:Bundle?) -> UIView? {
        
        return UINib(nibName:nibNamed, bundle:bundle).instantiate(withOwner: nil, options:nil)[0] as? UIView
        
    }
    
    public func addCenteredAndReturnYConstraint(_ view:UIView) -> NSLayoutConstraint {
        
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let centerXConstraint = NSLayoutConstraint(item:view, attribute:.centerX, relatedBy:.equal, toItem:self, attribute:.centerX, multiplier:1, constant:0)
        
        addConstraint(centerXConstraint)
        
        let centerYConstraint = NSLayoutConstraint(item:view, attribute:.centerY, relatedBy:.equal, toItem:self, attribute:.centerY, multiplier:1, constant:0)
        
        addConstraint(centerYConstraint)
        
        let widthConstraint = NSLayoutConstraint(item:view, attribute:.width, relatedBy:.equal, toItem:nil, attribute:.notAnAttribute, multiplier:1, constant:view.frame.width)
        
        view.addConstraint(widthConstraint)
        
        let heightConstraint = NSLayoutConstraint(item:view, attribute:.height, relatedBy:.equal, toItem:nil, attribute:.notAnAttribute, multiplier:1, constant:view.frame.height)
        
        view.addConstraint(heightConstraint)
        
        
        return centerYConstraint
        
    }
    
    public func addViewToFill(_ view:UIView) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        
        let viewDict = ["view":view]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options:[.alignAllTop, .alignAllBottom], metrics:nil, views:viewDict))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options:[.alignAllLeft, .alignAllRight], metrics:nil, views:viewDict))
        
        layoutIfNeeded()
        
    }
    
    public func addViewToFill(_ view:UIView, topSpace:CGFloat, bottomSpace:CGFloat) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        
        let viewDict = ["view":view]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(\(topSpace))-[view]-(\(bottomSpace))-|", options:[.alignAllTop, .alignAllBottom], metrics:nil, views:viewDict))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options:[.alignAllLeft, .alignAllRight], metrics:nil, views:viewDict))
        
        layoutIfNeeded()
        
    }
    
    public func addViewWithSizeAndCenterX(_ view:UIView, top:CGFloat, size:CGSize) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        
        let widthConstraint = NSLayoutConstraint(item:view, attribute:.width, relatedBy:.equal, toItem:nil, attribute:.notAnAttribute, multiplier:1, constant:size.width)
        
        view.addConstraint(widthConstraint)
        
        let heightConstraint = NSLayoutConstraint(item:view, attribute:.height, relatedBy:.equal, toItem:nil, attribute:.notAnAttribute, multiplier:1, constant:size.height)
        
        view.addConstraint(heightConstraint)
        
        addConstraint(NSLayoutConstraint(item:view, attribute:.centerX, relatedBy:.equal, toItem:self, attribute:.centerX, multiplier:1, constant:0))
        
        addConstraint(NSLayoutConstraint(item:view, attribute:.top, relatedBy:.equal, toItem:self, attribute:.top, multiplier:1, constant:top))
        
        layoutIfNeeded()
        
    }
    
    public func addViewAtIndexWithSizeAndCenter(_ view:UIView, index:Int, size:CGSize) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        insertSubview(view, at:index)
        
        let widthConstraint = NSLayoutConstraint(item:view, attribute:.width, relatedBy:.equal, toItem:nil, attribute:.notAnAttribute, multiplier:1, constant:size.width)
        
        view.addConstraint(widthConstraint)
        
        let heightConstraint = NSLayoutConstraint(item:view, attribute:.height, relatedBy:.equal, toItem:nil, attribute:.notAnAttribute, multiplier:1, constant:size.height)
        
        view.addConstraint(heightConstraint)
        
        addConstraint(NSLayoutConstraint(item:view, attribute:.centerX, relatedBy:.equal, toItem:self, attribute:.centerX, multiplier:1, constant:0))
        
        addConstraint(NSLayoutConstraint(item:view, attribute:.centerY, relatedBy:.equal, toItem:self, attribute:.centerY, multiplier:1, constant:0))
        
        layoutIfNeeded()
        
    }
    
    public func addViewCentered(_ view:UIView) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        
        addConstraint(NSLayoutConstraint(item:view, attribute:.centerX, relatedBy:.equal, toItem:self, attribute:.centerX, multiplier:1, constant:0))
        
        addConstraint(NSLayoutConstraint(item:view, attribute:.centerY, relatedBy:.equal, toItem:self, attribute:.centerY, multiplier:1, constant:0))
        
        let viewDict = ["view":view]
        
        let options = NSLayoutFormatOptions.alignAllLeft.rawValue | NSLayoutFormatOptions.alignAllRight.rawValue
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[view]-10-|", options:NSLayoutFormatOptions(rawValue:options), metrics:nil, views:viewDict))
        
        layoutIfNeeded()
        
    }
    
    public func addViewsCenteredVertically(_ topView:UIView, bottomView:UIView) {
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(topView)
      
        addSubview(bottomView)
        
        addConstraint(NSLayoutConstraint(item:topView, attribute:.centerX, relatedBy:.equal, toItem:self, attribute:.centerX, multiplier:1, constant:0))
        
        addConstraint(NSLayoutConstraint(item:topView, attribute:.centerY, relatedBy:.equal, toItem:self, attribute:.centerY, multiplier:1, constant:-topView.frame.height))
        
        addConstraint(NSLayoutConstraint(item:bottomView, attribute:.centerX, relatedBy:.equal, toItem:self, attribute:.centerX, multiplier:1, constant:0))
        
        addConstraint(NSLayoutConstraint(item:bottomView, attribute:.centerY, relatedBy:.equal, toItem:self, attribute:.centerY, multiplier:1, constant:topView.frame.height))
        
        let viewDict = ["topView":topView, "bottomView":bottomView]
        
        let options = NSLayoutFormatOptions.alignAllLeft.rawValue | NSLayoutFormatOptions.alignAllRight.rawValue
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[topView]-10-|", options:NSLayoutFormatOptions(rawValue:options), metrics:nil, views:viewDict))
    
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[bottomView]-10-|", options:NSLayoutFormatOptions(rawValue:options), metrics:nil, views:viewDict))
        
        layoutIfNeeded()
        
    }
    
    //MARK: - Helpers
    
    fileprivate func createLayer(_ colors: [UIColor]) -> CAGradientLayer {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = bounds
        
        var refColors = [CGColor]()
        
        for color in colors {
            
            refColors.append(color.cgColor)
            
        }
        
        gradientLayer.colors = refColors
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        
        gradientLayer.endPoint = CGPoint(x: 0.6, y: 1.0)
        
        return gradientLayer
        
    }
    
}
