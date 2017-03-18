
import UIKit
import FoundationKit

private let top = CGFloat(67)
private let perspectiveGestureSelector: Selector = #selector(ViewController.perspectiveGesture(_:))

extension ViewController {
    
    public func perspectiveTransform(_ viewController:ViewController, offset:CGFloat) -> CATransform3D {
        
        let percentage = 1 - (offset / (viewController.view.frame.height / 2))
        
        viewController.opacityView?.alpha = max(0, min(0.5, percentage))
        
        var scale = 1 - (0.1 * percentage)
        
        scale = min(scale, 1)
        
        var transform = CATransform3DIdentity
        
        transform = CATransform3DScale(transform, scale, scale, 1)
        
        return transform
        
    }
    
    public func showPerspectiveViewController(_ viewController:ViewController!, completion:VoidCompletion?) {
        
        if let parentController = rootViewController() as? ViewController {
            
            parentController.opacityView?.isHidden = false
            
            if let parentView = parentController.view {
                
                let viewToAdd = viewController.view
                
                viewToAdd?.frame = parentView.bounds
                
                viewToAdd?.layoutIfNeeded()
                
                
                parentController.addChildViewController(viewController)
                
                parentController.view.addSubview(viewToAdd!)
                
                
                viewToAdd?.translatesAutoresizingMaskIntoConstraints = false
                
                addMarginConstraints(viewController, contentView:parentView, top:parentView.frame.height, bottom:parentView.frame.height - top, left:0, right:0)
                
                viewController.didMove(toParentViewController: parentController)
                
                
                viewToAdd?.layoutIfNeeded()
                
                
                viewController?.topConstraint?.constant = top
                
                viewController?.bottomConstraint?.constant = 0
                
                let layer = parentController.perspectiveView?.layer
                
                let transform = perspectiveTransform(parentController, offset:top)
                
                parentController.opacityView?.alpha = 0
                
                UIView.animate(withDuration: 0.25, delay:0, options:.curveEaseIn, animations: {
                    
                    layer?.transform = transform
                    
                    parentView.layoutIfNeeded()
                    
                    parentController.opacityView?.alpha = 0.5
                    
                }) { finished in
                    
                    completion?()
                    
                }
                
            }
            
        }
        
    }
    
    public func hidePerspectiveViewController() {
        
        removePerspectiveGesture()
        
        if let parentController = rootViewController() as? ViewController {
            
            parentController.view.layoutIfNeeded()
            
            willMove(toParentViewController: nil)
            
            if bottomConstraint != nil && topConstraint != nil && parentController.perspectiveView != nil {
                
                let layer = parentController.perspectiveView.layer
                
                let transform = CATransform3DIdentity
                
                bottomConstraint?.constant = view.frame.height
                
                topConstraint?.constant += view.frame.height
                
                UIView.animate(withDuration: 0.25, delay:0, options:.curveEaseOut, animations: {
                    
                    layer.transform = transform
                    
                    parentController.view.layoutIfNeeded()
                    
                    parentController.opacityView?.alpha = 0
                    
                }) { [weak self] finished in
                    
                    if let instance = self {
                        
                        parentController.opacityView?.isHidden = true
                        
                        instance.view.removeFromSuperview()
                        
                        instance.removeFromParentViewController()
                        
                    }
                    
                }
                
            } else {
                
                view.removeFromSuperview()
                
                removeFromParentViewController()
                
            }
            
        }
        
    }
    
    //MARK: - Gestures
    
    public func setupPerspectiveGesture() {
        
        perspectiveGesture = UIPanGestureRecognizer(target:self, action:perspectiveGestureSelector)
        
    }
    
    public func addPerspectiveGesture() {
        
        if let perspectiveGesture = perspectiveGesture {
            
            view.addGestureRecognizer(perspectiveGesture)
            
        }
        
    }
    
    public func removePerspectiveGesture() {
        
        if let perspectiveGesture = perspectiveGesture {
            
            view.removeGestureRecognizer(perspectiveGesture)
            
        }
        
    }
    
    //MARK: - UIPanGestureRecognizer
    
    func perspectiveGesture(_ sender:UIPanGestureRecognizer) {
        
        if sender.state == .began {
            
            originTop = topConstraint?.constant ?? 0
            
            originBottom = bottomConstraint?.constant ?? 0
            
        } else {
            
            if let viewMoving = sender.view {
                
                let translation = sender.translation(in: viewMoving)
                
                let destinationTop = max(-originTop, originTop + translation.y)
                
                let destinationBottom = max(0, originBottom + translation.y)
                
                if sender.state == .changed {
                    
                    if let parentController = topViewController() as? ViewController {
                        
                        parentController.perspectiveView.layer.transform = perspectiveTransform(parentController, offset:destinationTop)
                        
                        topConstraint?.constant = destinationTop
                        
                        bottomConstraint?.constant = destinationBottom
                        
                    }
                    
                } else if sender.state == .ended || sender.state == .cancelled {
                    
                    let finalTop = destinationTop + (0.35 * sender.velocity(in: viewMoving).y)
                    
                    if finalTop >= view.frame.height / 2 {
                        
                        hidePerspectiveViewController()
                        
                    } else if finalTop < view.frame.height / 2 {
                        
                        topConstraint?.constant = originTop
                        
                        bottomConstraint?.constant = originBottom
                        
                        if let parentController = topViewController() as? ViewController {
                            
                            let layer = parentController.perspectiveView.layer
                            
                            UIView.animate(withDuration: 0.25, delay:0, options:.curveEaseOut, animations: {
                                
                                self.view.layoutIfNeeded()
                                
                                layer.transform = self.perspectiveTransform(parentController, offset:self.originTop)
                                
                                parentController.view.layoutIfNeeded()
                                
                                }, completion:nil)
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    //MARK: UIGestureRecognizerDelegate
    
    open func gestureRecognizerShouldBegin(_ sender:UIGestureRecognizer) -> Bool {
        
        var shouldBegin = false
        
        if sender == perspectiveGesture {
            
            let position = sender.location(in: sender.view)
            
            if position.y < 60 {
                
                shouldBegin = true
                
            }
            
        }
        
        return shouldBegin
        
    }
    
}
