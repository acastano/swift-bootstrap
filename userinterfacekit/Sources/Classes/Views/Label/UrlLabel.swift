
import UIKit
import Foundation

public protocol UrlLabelDelegate: class {
    
    func urlTapped(_ label: UrlLabel, url: URL)
    
}

open class UrlLabel: UILabel {
    
    fileprivate var urls: NSMutableDictionary = [:]
    fileprivate var delegate: UrlLabelDelegate?
    
    open override func awakeFromNib() {
        
        super.awakeFromNib()
        
        addGesture()
        
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addGesture()
        
    }

    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    fileprivate func addGesture() {
        
        isUserInteractionEnabled = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UrlLabel.didTapLabel(_:))))
        
    }
    
    open func setKeyedUrls(_ text:NSMutableAttributedString, dictionary: [String:String], linkColor: UIColor, delegate: UrlLabelDelegate?) {
        
        self.delegate = delegate
        
        var attribText = text
        
        for (key, urlString) in dictionary {
            
            if let url = URL(string: urlString) {
                
                let range = text.mutableString.range(of: key)
                
                attribText = addLinkAttributes(attribText, range: range, linkColor: linkColor)
                
                urls[url] = range
                
            }
            
        }
        
        attributedText = attribText
        
    }
    
    fileprivate func addLinkAttributes(_ attributedString: NSMutableAttributedString, range: NSRange, linkColor: UIColor) -> NSMutableAttributedString {
        
        let text = NSMutableAttributedString(attributedString: attributedString)
        
        text.addAttributes([NSForegroundColorAttributeName:linkColor], range: range)
        text.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: range)
        text.addAttribute(NSUnderlineColorAttributeName, value: linkColor, range: range)
        
        return text
        
    }
    
    internal func didTapLabel(_ tapGesture: UITapGestureRecognizer) {
        
        if urls.count > 0 {
            
            if let text = attributedText {
                
                let attributedString = NSMutableAttributedString(attributedString: text)
                
                attributedString.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, attributedString.string.characters.count))
                
                let textStorage = NSTextStorage(attributedString: attributedString)
                
                let layoutManager = NSLayoutManager()
                
                let textContainer = NSTextContainer(size: CGSize(width: frame.size.width, height: frame.size.height))
                
                textContainer.lineFragmentPadding = 0
                
                textContainer.lineBreakMode = lineBreakMode
                
                textContainer.maximumNumberOfLines = numberOfLines
                
                let labelSize = bounds.size
                
                textContainer.size = labelSize
                
                layoutManager.addTextContainer(textContainer)
                
                textStorage.addLayoutManager(layoutManager)
                
                let locationOfTouchInLabel = tapGesture.location(in: self)
                
                let textBoundingBox = layoutManager.usedRect(for: textContainer)
                
                let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                                      y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
                
                let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                                 y: locationOfTouchInLabel.y - textContainerOffset.y)
                
                let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer,
                                                                            in:textContainer,
                                                                            fractionOfDistanceBetweenInsertionPoints: nil)
                for (url, value) in self.urls {
                    
                    if let range = value as? NSRange,
                        let url = url as? URL {
                        
                        if NSLocationInRange(indexOfCharacter, range) {
                            
                            self.delegate?.urlTapped(self, url: url)
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}
