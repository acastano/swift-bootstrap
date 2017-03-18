
import UIKit

open class Button: UIButton {
    
    open var initialHeight = CGFloat(0)
    
    @IBOutlet open weak var topConstraint: NSLayoutConstraint?
    @IBOutlet open weak var leftConstraint: NSLayoutConstraint?
    @IBOutlet open weak var widthConstraint: NSLayoutConstraint?
    @IBOutlet open weak var rightConstraint: NSLayoutConstraint?
    @IBOutlet open weak var heightConstraint: NSLayoutConstraint?
    @IBOutlet open weak var bottomConstraint: NSLayoutConstraint?
    
    @IBOutlet open weak var centerXConstraint: NSLayoutConstraint?
    @IBOutlet open weak var centerYConstraint: NSLayoutConstraint?
    
    open override func awakeFromNib() {
        
        super.awakeFromNib()
        
        initialHeight = heightConstraint?.constant ?? 0
        
    }
    
}
