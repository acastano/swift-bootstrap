
import UIKit
import FoundationKit

public extension UIViewController {
    
    public func rootViewController() -> UIViewController {
        
        let viewController = self
        
        var controller = viewController.parent
        
        if controller == nil {
            
            controller = viewController
            
            if controller?.presentingViewController != nil {
                
                controller = controller!.presentingViewController
                
                return controller!.rootViewController()
                
            }else if let navController = controller as? UINavigationController , navController.viewControllers.count > 0 {
                
                controller = navController.viewControllers[0]
                
            }
            
            return controller!
            
        }else {
            
            return controller!.rootViewController()
            
        }
        
    }
    
    public func topViewController() -> UIViewController {
        
        let viewController = self
        
        var controller = viewController.presentedViewController
        
        if controller == nil {
            
            controller = viewController
            
            if controller?.parent != nil {
                
                controller = controller!.parent
                
                return controller!.topViewController()
                
            }else if let navController = controller as? UINavigationController , navController.viewControllers.count > 0 {
                
                controller = navController.viewControllers.last
                
            }
            
            return controller!
            
        }else {
            
            return controller!.topViewController()
            
        }
        
    }
    
    public func topChildViewController() -> UIViewController? {
        
        let last = childViewControllers.last
        
        if last is UIPageViewController, let pageViewController = last as? UIPageViewController,
            let viewController = pageViewController.viewControllers?.last {
                
                return viewController.topChildViewController()
                
        }
        
        return last
        
    }
    
    public func popToRootViewController(_ animated:Bool) {
        
       _ = navigationController?.popToRootViewController(animated: animated)
        
    }
    
    public func hideViewController(_ viewController:UIViewController!) {
        
        hideViewController(viewController, animated:true)
        
    }
    
    public func hideViewController(_ viewController:UIViewController, duration:Double, completion:VoidCompletion?) {
        
        hideViewController(viewController, animated:true, duration:duration, completion:completion)
        
    }
    
    public func hideViewController(_ viewController:UIViewController, animated:Bool) {
        
        hideViewController(viewController, animated:animated, duration:0.25, completion:nil)
        
    }
    
    public func hideViewController(_ viewController:UIViewController, animated:Bool, duration:Double, completion:VoidCompletion?) {
        
        if isModalController(viewController) {
            
            viewController.dismiss(animated: animated, completion:completion)
            
        } else {
            
            let controller = navigationController?.viewControllers.last
            
            if controller == viewController {
                
               _ = navigationController?.popViewController(animated: animated)
                
            }else {
                
                viewController.willMove(toParentViewController: nil)
                
                if animated {
                    
                    UIView.animate(withDuration: duration, delay:0, options:[], animations: {
                        
                        viewController.view.alpha = 0
                        
                        viewController.view.layoutIfNeeded()
                        
                        }) { finished in
                            
                            self.removeViewController(viewController, completion:completion)
                            
                    }
                    
                } else {
                    
                    removeViewController(viewController, completion:completion)
                    
                }
                
            }
            
        }
        
    }
    
    fileprivate func removeViewController(_ viewController:UIViewController, completion:VoidCompletion?) {
        
        completion?()
        
        viewController.view.alpha = 1
        
        viewController.view.removeFromSuperview()
        
        viewController.removeFromParentViewController()
        
    }
    
    fileprivate func isModalController(_ viewController:UIViewController) -> Bool {
        
        var isModal = false
        
        if viewController.presentingViewController != nil {
            
            if viewController.parent == nil {
            
                isModal = true
                
            } else if let navigationController = viewController.parent as? UINavigationController {
                
                if let firstViewController = navigationController.viewControllers.first , viewController == firstViewController {
                
                    isModal = true
                    
                }

            }
        
        }
        
        return isModal
        
    }
    
}
