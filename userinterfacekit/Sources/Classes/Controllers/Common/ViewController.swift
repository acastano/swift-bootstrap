
import UIKit
import FoundationKit

open class ViewController: UIViewController {
    
    open var showingTabBar = false
    open var animateKeyboard = true
    open var originTop = CGFloat(0)
    open var originBottom = CGFloat(0)
    open var keepStatusBarStyle = false
    open var keyboardHeight = CGFloat(0)
    open var keyboardCompletion: BoolCompletion?
    open var perspectiveGesture: UIPanGestureRecognizer?
    
    #if os(iOS)
    fileprivate var previousStatusStyle: UIStatusBarStyle!
    #endif
    
    @IBOutlet open weak var opacityView: UIView!
    @IBOutlet open weak var perspectiveView: UIView!
    @IBOutlet open weak var keyboardField: UITextField?

    @IBOutlet open weak var topConstraint: NSLayoutConstraint?
    @IBOutlet open weak var leftConstraint: NSLayoutConstraint?
    @IBOutlet open weak var rightConstraint: NSLayoutConstraint?
    @IBOutlet open weak var bottomConstraint: NSLayoutConstraint?
    @IBOutlet open weak var heightConstraint: NSLayoutConstraint?
    @IBOutlet open weak var keyboardConstraint: NSLayoutConstraint?

    //MARK: - Initialisers
    
    deinit {
        
        #if os(iOS)
        deregisterObservers()
        #endif
        
    }
    
    //MARK: - Life cycle
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        keyboardConstraint?.constant = keyboardHeight
        
    }
    
    open override func viewWillAppear(_ animated:Bool) {
        
        super.viewWillAppear(animated)
        
        if keepStatusBarStyle == false {
        
            #if os(iOS)
                
            previousStatusStyle = UIApplication.shared.statusBarStyle
            
            UIApplication.shared.setStatusBarStyle(preferredStatusBarStyle, animated:animated)
                
            #endif
            
        }
        
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        #if os(iOS)
            
        if keepStatusBarStyle == false, let parentController = parent as? ViewController {
            
            let style: UIStatusBarStyle!
            
            let count = parentController.childViewControllers.count
            
            if count > 1 {
                
               style = parentController.childViewControllers[count - 2].preferredStatusBarStyle
                
            } else {
                
                style = parentController.preferredStatusBarStyle
                
            }
            
            UIApplication.shared.setStatusBarStyle(style, animated:animated)
            
        }
        
        #endif
        
    }
    
    //MARK: - Controllers
    
    open func presentViewController(_ viewController:UIViewController, animated:Bool, addNavigation:Bool, completion:VoidCompletion?) {
        
        if addNavigation {
        
            let navController = UINavigationController(rootViewController:viewController)
        
            navController.isNavigationBarHidden = true
        
            present(navController, animated:animated, completion:completion)
            
        } else {
            
            present(viewController, animated:animated, completion:completion)

        }

    }

    open func pushViewControllerAndAjustKeyboard(_ viewController:ViewController, animated:Bool) {

        viewController.keyboardHeight = keyboardConstraint?.constant ?? 0

        navigationController?.pushViewController(viewController, animated:animated)
        
    }
    
    open func pushViewController(_ viewController:ViewController, animated:Bool) {

        navigationController?.pushViewController(viewController, animated:animated)
        
    }
    
    open func showViewController(_ viewController:ViewController, animated:Bool) {
        
        if animated {
            
            showViewControllerAnimated(viewController)
            
        } else {
            
            showViewController(viewController)
            
        }
        
    }
    
    open func showViewControllerAnimated(_ viewController:ViewController, prepareCompletion:VoidCompletion?) {
        
        showViewController(viewController)

        prepareCompletion?()
        
        viewController.view.alpha = 0

        UIView.animate(withDuration: 0.3, animations: {
            
            viewController.view.alpha = 1
            
            viewController.view.layoutIfNeeded()
            
        }) 
        
    }
    
    open func showViewControllerAnimated(_ viewController:ViewController) {
        
        viewController.view.alpha = 0
        
        showViewController(viewController)
        
        UIView.animate(withDuration: 0.3, animations: {
            
            viewController.view.alpha = 1
            
            viewController.view.layoutIfNeeded()
            
        }) 
        
    }
    
    open func showViewControllerAnimatedAndAjustKeyboard(_ viewController:ViewController) {
        
        viewController.keyboardHeight = keyboardConstraint?.constant ?? 0
        
        showViewControllerAnimated(viewController)
        
    }
    
    open func showViewControllerAndAjustKeyboard(_ viewController:ViewController) {
        
        viewController.keyboardHeight = keyboardConstraint?.constant ?? 0
        
        showViewController(viewController)
        
    }
    
    func showViewController(_ viewController:ViewController) {
        
        let parentController = topViewController()
        
        addToController(viewController, contentView:parentController.view, to:parentController, belowView:nil)
        
    }
    
    open func showChildViewControllerAnimatedAndAdjustKeyboard(_ viewController:ViewController) {
        
        viewController.keyboardHeight = keyboardConstraint?.constant ?? 0
        
        showChildViewControllerAnimated(viewController, contentView:view)
        
    }
    
    open func showChildViewControllerAnimatedAndAdjustKeyboard(_ viewController:ViewController, prepareCompletion:VoidCompletion?) {
        
        viewController.keyboardHeight = keyboardConstraint?.constant ?? 0
        
        showChildViewController(viewController, contentView:view, replacingTopViewController:false)
        
        prepareCompletion?()
        
        viewController.view.alpha = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            
            viewController.view.alpha = 1
            
            viewController.view.layoutIfNeeded()
            
        }) 
        
    }
    
    open func showChildViewControllerAnimated(_ viewController:UIViewController, contentView:UIView) {
        
        showChildViewControllerAnimated(viewController, contentView:contentView, replacingTopViewController:false)
        
    }
    
    open func showChildViewControllerAnimated(_ viewController:UIViewController, contentView:UIView, replacingTopViewController:Bool) {
        
        showChildViewController(viewController, contentView:contentView, replacingTopViewController:replacingTopViewController)
        
        viewController.view.alpha = 0

        UIView.animate(withDuration: 0.3, animations: {
            
            viewController.view.alpha = 1
            
            viewController.view.layoutIfNeeded()
            
        }) 
        
    }
    
    open func showChildViewController(_ viewController:UIViewController, contentView:UIView, replacingTopViewController:Bool) {
        
        showChildViewController(viewController, contentView:contentView, belowView:nil, replacingTopViewController:replacingTopViewController)
        
    }
    
    open func showChildViewController(_ viewController:UIViewController, contentView:UIView, belowView:UIView?, replacingTopViewController:Bool) {
        
        let controller = topChildViewController()
        
        if let controller = controller , replacingTopViewController == true {
            
            hideViewController(controller, animated: false)
            
        }
        
        let parentController = self
        
        addToController(viewController, contentView:contentView, to:parentController, belowView:belowView)
        
    }
    
    open func addView(_ view:UIView, to contentView:UIView) {
        
        contentView.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addMarginConstraints(view, contentView:contentView, top:0, bottom:0, left:0, right:0, width:nil, height:nil)
        
    }
    
    open func addCenteredView(_ view:UIView, to contentView:UIView) {
        
        contentView.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addCenterMargins(view, to:contentView)
        
    }
    
    open func addViewWithWidthConstraint(_ view:UIView, to contentView:UIView, width:CGFloat) {
        
        contentView.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addMarginConstraints(view, contentView:contentView, top:0, bottom:nil, left:0, right:0, width:width, height:nil)
        
    }
    
    open func addViewWithHeightConstraint(_ view:UIView, to contentView:UIView, height:CGFloat) {
        
        contentView.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addMarginConstraints(view, contentView:contentView, top:0, bottom:nil, left:0, right:0, width:nil, height:height)
        
    }
    
    fileprivate func addToController(_ viewController:UIViewController, contentView:UIView, to parentController:UIViewController, belowView:UIView?) {
        
        viewController.willMove(toParentViewController: parentController)

        parentController.addChildViewController(viewController)
        
        if let belowView = belowView {
            
            contentView.insertSubview(viewController.view, belowSubview:belowView)
            
        } else {
            
            contentView.addSubview(viewController.view)
            
        }
        
        viewController.view.frame = contentView.bounds
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        if let controller = viewController as? ViewController {
            
            addMarginConstraints(controller, contentView:contentView, top:0, bottom:0, left:0, right:0)
            
        } else {
            
            addMarginConstraints(viewController.view, contentView:contentView, top:0, bottom:0, left:0, right:0, width:nil, height:nil)
            
        }
        
        viewController.didMove(toParentViewController: parentController)
        
        UIView.performWithoutAnimation {
        
            viewController.view.layoutIfNeeded()
            
        }
        
    }
    
    fileprivate func addCenterMargins(_ view:UIView, to contentView:UIView) {
        
        let centerXConstraint = NSLayoutConstraint(item:view, attribute:.centerX, relatedBy:.equal, toItem:contentView, attribute:.centerX, multiplier:1, constant:0)
        
        contentView.addConstraint(centerXConstraint)
        
        let centerYConstraint = NSLayoutConstraint(item:view, attribute:.centerY, relatedBy:.equal, toItem:contentView, attribute:.centerY, multiplier:1, constant:0)
                
        contentView.addConstraint(centerYConstraint)
        
        let widthConstraint = NSLayoutConstraint(item:view, attribute:.width, relatedBy:.equal, toItem:nil, attribute:.notAnAttribute, multiplier:1, constant:view.frame.width)
        
        view.addConstraint(widthConstraint)
        
        let heightConstraint = NSLayoutConstraint(item:view, attribute:.height, relatedBy:.equal, toItem:nil, attribute:.notAnAttribute, multiplier:1, constant:view.frame.height)
        
        view.addConstraint(heightConstraint)
        
    }
    
    open func addMarginConstraints(_ viewController:ViewController, contentView:UIView, top:CGFloat?, bottom:CGFloat, left:CGFloat, right:CGFloat) {
        
        if let top = top {
            
            viewController.topConstraint = NSLayoutConstraint(item:viewController.view, attribute:.top, relatedBy:.equal, toItem:contentView, attribute:.top, multiplier:1, constant:top)
            
            contentView.addConstraint(viewController.topConstraint!)
            
        }
        
        viewController.leftConstraint = NSLayoutConstraint(item:contentView, attribute:.left, relatedBy:.equal, toItem:viewController.view , attribute:.left, multiplier:1, constant:left)
        
        contentView.addConstraint(viewController.leftConstraint!)
        
        viewController.rightConstraint = NSLayoutConstraint(item:contentView, attribute:.right, relatedBy:.equal, toItem:viewController.view , attribute:.right, multiplier:1, constant:right)
        
        contentView.addConstraint(viewController.rightConstraint!)
        
        viewController.bottomConstraint = NSLayoutConstraint(item:viewController.view, attribute:.bottom, relatedBy:.equal, toItem:contentView, attribute:.bottom, multiplier:1, constant:bottom)
        
        contentView.addConstraint(viewController.bottomConstraint!)
        
    }
    
    fileprivate func addMarginConstraints(_ view:UIView, contentView:UIView, top:CGFloat?, bottom:CGFloat?, left:CGFloat, right:CGFloat, width:CGFloat?, height:CGFloat?) {
        
        if let top = top {
            
            let topConstraint = NSLayoutConstraint(item:view, attribute:.top, relatedBy:.equal, toItem:contentView, attribute:.top, multiplier:1, constant:top)
            
            contentView.addConstraint(topConstraint)
            
            if let imageView = view as? ImageView {
                
                imageView.topConstraint = topConstraint
                
            }
            
        }
        
        if let bottom = bottom {
            
            let bottomConstraint = NSLayoutConstraint(item:view, attribute:.bottom, relatedBy:.equal, toItem:contentView, attribute:.bottom, multiplier:1, constant:bottom)
            
            contentView.addConstraint(bottomConstraint)
            
        }
        
        if let width = width {
            
            let widthConstraint = NSLayoutConstraint(item:view, attribute:.width, relatedBy:.equal, toItem:nil, attribute:.notAnAttribute, multiplier:1, constant:width)
            
            contentView.addConstraint(widthConstraint)
            
        }
        
        if let height = height {
            
            let heightConstraint = NSLayoutConstraint(item:view, attribute:.height, relatedBy:.equal, toItem:nil, attribute:.notAnAttribute, multiplier:1, constant:height)
            
            view.addConstraint(heightConstraint)
            
        }
        
        let leftConstraint = NSLayoutConstraint(item:contentView, attribute:.left, relatedBy:.equal, toItem:view, attribute:.left, multiplier:1, constant:left)
        
        contentView.addConstraint(leftConstraint)
        
        let rightConstraint = NSLayoutConstraint(item:contentView, attribute:.right, relatedBy:.equal, toItem:view, attribute:.right, multiplier:1, constant:right)
        
        contentView.addConstraint(rightConstraint)
        
    }
    
}
