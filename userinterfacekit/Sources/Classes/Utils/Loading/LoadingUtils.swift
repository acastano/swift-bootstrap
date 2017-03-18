
import UIKit

private let kLoadingTag = 15435
private let kBackgroundTag = 15436
private let cornerRadius = CGFloat(6)
private let backgroundAlpha = CGFloat(0.65)

open class LoadingUtils: NSObject {
    
    open class func showLoadingImage(_ view:UIView, yOffset: CGFloat, images:[UIImage], imageSize:CGFloat, animationDuration:TimeInterval, ignoreInteractionEvents:Bool) {
        
        if ignoreInteractionEvents {
            
            UIApplication.shared.beginIgnoringInteractionEvents()
            
        }
        
        if view.viewWithTag(kLoadingTag) == nil {
            
            let loadingView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
            
            loadingView.animationImages = images
            
            loadingView.animationDuration = animationDuration
            
            loadingView.startAnimating()
            
            addBackgroundView(yOffset, to: view)
            
            addLoadingView(loadingView, to:view)
            
        }
        
    }
    
    open class func showLoadingImage(_ view:UIView, images:[UIImage], imageSize:CGFloat, animationDuration:TimeInterval) {
        
        if view.viewWithTag(kLoadingTag) == nil {
            
            let loadingView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
            
            loadingView.animationImages = images
            
            loadingView.animationDuration = animationDuration
            
            loadingView.startAnimating()
            
            addLoadingView(loadingView, to:view)
            
        }
        
    }
    
    open class func showLoading(_ view:UIView, activityIndicatorViewStyle:UIActivityIndicatorViewStyle, ignoreInteractionEvents:Bool) {
        
        if ignoreInteractionEvents {
            
            UIApplication.shared.beginIgnoringInteractionEvents()
            
        }
        
        showLoading(view, activityIndicatorViewStyle:activityIndicatorViewStyle)
        
    }
    
    open class func showLoading(_ view:UIView, activityIndicatorViewStyle:UIActivityIndicatorViewStyle) {
        
        if view.viewWithTag(kLoadingTag) == nil {
            
            let loadingView = activityIndicator(activityIndicatorViewStyle)
            
            addLoadingView(loadingView, to:view)
            
        }
        
    }
    
    open class func showLoading(_ view:UIView, message:String) {
        
        if view.viewWithTag(kLoadingTag) == nil {
            
            let loadingView = loadingLabel(message)
            
            addLoadingView(loadingView, to:view)
            
        }
        
    }
    
    fileprivate class func addLoadingView(_ loadingView:UIView, to view:UIView) {
        
        loadingView.tag = kLoadingTag
        
        view.addSubview(loadingView)
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(NSLayoutConstraint(item:loadingView, attribute:.centerX, relatedBy:.equal, toItem:view, attribute:.centerX, multiplier:1, constant:0))
        
        view.addConstraint(NSLayoutConstraint(item:loadingView, attribute:.centerY, relatedBy:.equal, toItem:view, attribute:.centerY, multiplier:1, constant:0))
        
        view.addConstraint(NSLayoutConstraint(item: loadingView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: loadingView.frame.width))
        
        view.addConstraint(NSLayoutConstraint(item: loadingView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: loadingView.frame.height))
        
        view.layoutIfNeeded()
        
    }
    
    fileprivate class func addBackgroundView(_ yOffset: CGFloat, to view:UIView) {
        
        let backgroundView = UIView(frame: CGRect(x: 0, y: -yOffset, width: UIScreen.width(), height: UIScreen.height()))
        
        backgroundView.backgroundColor = UIColor.black
        
        backgroundView.alpha = backgroundAlpha
        
        backgroundView.tag = kBackgroundTag

        view.addSubview(backgroundView)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(NSLayoutConstraint(item:backgroundView, attribute:.centerX, relatedBy:.equal, toItem:view, attribute:.centerX, multiplier:1, constant:0))
        
        view.addConstraint(NSLayoutConstraint(item:backgroundView, attribute:.centerY, relatedBy:.equal, toItem:view, attribute:.centerY, multiplier:1, constant:0))
        
        view.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: backgroundView.frame.width))
        
        view.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: backgroundView.frame.height))
        
        view.layoutIfNeeded()
        
    }

    open class func hideLoading(_ view:UIView, endIgnoreInteractionEvents:Bool) {
        
        if endIgnoreInteractionEvents {
            
            UIApplication.shared.endIgnoringInteractionEvents()
            
        }
        
        hideLoading(view)
        
    }
    
    open class func hideLoading(_ view:UIView) {
        
        if let loadingView = view.viewWithTag(kLoadingTag) {
            
            UIView.animate(withDuration: 0.2, animations: {
                
                loadingView.alpha = 0.0
                
                }, completion: { finished in
                    
                    loadingView.removeFromSuperview()
                    
            })
            
        }
        
        if let backgroundView = view.viewWithTag(kBackgroundTag) {
            
            UIView.animate(withDuration: 0.2, animations: {
                
                backgroundView.alpha = 0.0
                
                }, completion: { finished in
                    
                    backgroundView.removeFromSuperview()
                    
            })
            
        }
        
    }
    
    fileprivate class func loadingLabel(_ message:String) -> UIView {
        
        let loadingView = UILabel()
        
        loadingView.textAlignment = .center
        
        loadingView.numberOfLines = 0
        
        loadingView.text = message
        
        return loadingView
        
    }
    
    fileprivate class func activityIndicator(_ activityIndicatorViewStyle:UIActivityIndicatorViewStyle) -> UIView {
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle:activityIndicatorViewStyle)
        
        indicator.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        
        indicator.startAnimating()
        
        return indicator
        
    }
    
    open class func toast(_ view:UIView, message:String) {
        
        showLoading(view, message: message)
        
        runOnMainThreadAfter(2) {
            
            self.hideLoading(view)
            
        }
        
    }
    
}
