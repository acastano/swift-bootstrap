
import UIKit

public extension UITapGestureRecognizer {
    
    public func didTapAttributedTextInLabel(_ label:UILabel, targetRange:NSRange) -> Bool {
        
        let labelSize = label.bounds.size

        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size:labelSize)

        layoutManager.addTextContainer(textContainer)

        if let attributedText = label.attributedText {
            
            let textStorage = NSTextStorage(attributedString:attributedText)
            
            textStorage.addLayoutManager(layoutManager)
            
        }
        
        textContainer.lineFragmentPadding = 0.0
        
        textContainer.lineBreakMode = label.lineBreakMode
        
        textContainer.maximumNumberOfLines = label.numberOfLines
        
        textContainer.size = labelSize
        
        let locationOfTouchInLabel = location(in: label)
        
        
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in:textContainer, fractionOfDistanceBetweenInsertionPoints:nil)
        
        let result = NSLocationInRange(indexOfCharacter, targetRange)
        
        return result
        
    }
    
}
