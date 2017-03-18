
import UIKit
import FoundationKit

private let tabBarHeight = CGFloat(44)

public let kKeyboardDidShowSelector = #selector(ViewController.keyboardDidShow(_:))
public let kKeyboardDidHideSelector = #selector(ViewController.keyboardDidHide(_:))
public let kKeyboardWillShowSelector = #selector(ViewController.keyboardWillShow(_:))
public let kKeyboardWillHideSelector = #selector(ViewController.keyboardWillHide(_:))
public let kKeyboardWillChangeSelector = #selector(ViewController.keyboardWillChange(_:))

extension ViewController {
    
    //MARK: TextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField:UITextField) {
        
        keyboardField = textField
        
        UIView.setAnimationsEnabled(animateKeyboard)
        
    }
    
    func textFieldDidEndEditing(_ textField:UITextField) {
        
        UIView.setAnimationsEnabled(animateKeyboard)
        
    }
    
    open func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        
        let nextTag = textField.tag + 1
        
        if let nextResponder = view.viewWithTag(nextTag) as? UITextField {
            
            keyboardField = textField
            
            nextResponder.becomeFirstResponder()
            
        } else {
            
            textField.resignFirstResponder()
            
        }
        
        return true
        
    }
    
    //MARK: Keyboard
    
    public func registerKeyboardChanges() {
        
        NotificationCenter.default.addObserver(self, selector:kKeyboardWillShowSelector, name:NSNotification.Name.UIKeyboardWillShow, object:nil)
        
    }
    
    public func deregisterObservers() {
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
    func animationDuration(_ notification:Notification) -> TimeInterval {
        
        let animationDuration = ((notification as NSNotification).userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval) ?? 0
        
        return animationDuration
        
    }
    
    func keyboardAnimationOptions(_ notification:Notification) -> UIViewAnimationOptions {
        
        var options = UIViewAnimationOptions()
        
        if let info = (notification as NSNotification).userInfo,
            let optionsOptional = info[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber {
            
            options = UIViewAnimationOptions(rawValue:UInt(optionsOptional.intValue))
            
        }
        
        return options
        
    }
    
    func keyboardHeight(_ notification:Notification) -> CGFloat {
        
        var height = CGFloat(0)
        
        if let info = (notification as NSNotification).userInfo, let kbFrame = info[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardFrame = kbFrame.cgRectValue
            
            height = keyboardFrame.size.height
            
        }
        
        return height
        
    }
    
    func animationConstraintWithVaue(_ constraint:CGFloat, duration:TimeInterval, options:UIViewAnimationOptions, completion:BoolCompletion?) {
        
        if let keyboardConstraint = keyboardConstraint {
            
            keyboardConstraint.constant = constraint
            
            UIView.animate(withDuration: duration, delay:0, options:options, animations: {
                
                self.view.layoutIfNeeded()
                
                }, completion:completion)
            
        }
        
    }
    
    func keyboardWillShow(_ notification:Notification) {
        
        UIView.setAnimationsEnabled(animateKeyboard)
        
        deregisterObservers()
        
        NotificationCenter.default.addObserver(self, selector:kKeyboardDidShowSelector, name:NSNotification.Name.UIKeyboardDidShow, object:nil)
        
        let height = keyboardHeight(notification) + (showingTabBar ? -tabBarHeight : 0)
        
        let duration = animateKeyboard ? animationDuration(notification) : 0
        
        let options = keyboardAnimationOptions(notification)
        
        animationConstraintWithVaue(height, duration:duration, options:options, completion:keyboardCompletion)
        
    }
    
    func keyboardDidShow(_ notification:Notification) {
        
        UIView.setAnimationsEnabled(true)
        
        deregisterObservers()
        
        NotificationCenter.default.addObserver(self, selector:kKeyboardWillHideSelector, name:NSNotification.Name.UIKeyboardWillHide, object:nil)
        
        NotificationCenter.default.addObserver(self, selector:kKeyboardWillChangeSelector, name:NSNotification.Name.UIKeyboardWillChangeFrame, object:nil)
        
    }
    
    func keyboardWillChange(_ notification:Notification) {
        
        let height = keyboardHeight(notification) + (showingTabBar ? -tabBarHeight : 0)
        
        let duration = animationDuration(notification)
        
        let options = keyboardAnimationOptions(notification)
        
        animationConstraintWithVaue(height, duration:duration, options:options, completion:keyboardCompletion)
        
    }
    
    func keyboardWillHide(_ notification:Notification) {
        
        UIView.setAnimationsEnabled(animateKeyboard)
        
        deregisterObservers()
        
        NotificationCenter.default.addObserver(self, selector:kKeyboardDidHideSelector, name:NSNotification.Name.UIKeyboardDidHide, object:nil)
        
        let duration = animateKeyboard ? animationDuration(notification) : 0
        
        let options = keyboardAnimationOptions(notification)
        
        animationConstraintWithVaue(0, duration:duration, options:options, completion:keyboardCompletion)
        
    }
    
    func keyboardDidHide(_ notification:Notification) {
        
        keyboardField = nil
        
        UIView.setAnimationsEnabled(true)
        
        deregisterObservers()
        
        NotificationCenter.default.addObserver(self, selector:kKeyboardWillShowSelector, name:NSNotification.Name.UIKeyboardWillShow, object:nil)
        
    }
    
}
