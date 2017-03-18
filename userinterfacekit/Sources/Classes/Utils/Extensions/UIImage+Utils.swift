
import UIKit

public extension UIImage {
    
    public func croppedImage(_ bounds:CGRect) -> UIImage? {
        
        let scale = UIScreen.main.scale
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, scale)
        
        let point = CGPoint(x:bounds.origin.x, y:bounds.origin.y)
        
        draw(at: point)
        
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return croppedImage
        
    }
    
    public func resizeWith(_ percentage: CGFloat) -> UIImage? {
        
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.image = self
        
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        imageView.layer.render(in: context)
        
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        
        UIGraphicsEndImageContext()
        
        return result
        
    }
    
    public class func mergeBundleImagesUsingTopAndBottomAsTringles(_ topImageName:String?, bottomImageName:String?) -> UIImage? {
        
        var mergedImage: UIImage?
        
        if let topImageName = topImageName, let topImage = UIImage(named:topImageName),
            let bottomImageName = bottomImageName, let bottomImage = UIImage(named:bottomImageName) {
            
            mergedImage = mergeImagesUsingTopAndBottomAsTringles(topImage, bottomImage: bottomImage)
            
        }
        
        return mergedImage
        
    }
    
    public class func mergeImagesUsingTopAndBottomAsTringles(_ topImage:UIImage?, bottomImage:UIImage?) -> UIImage? {
        
        var mergedImage: UIImage?
        
        if let topImage = topImage, let bottomImage = bottomImage {
            
            let scale = UIScreen.main.scale
            
            let size = CGSize(width: topImage.size.width, height: topImage.size.height)
            
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            
            let context = UIGraphicsGetCurrentContext()
            
            context?.beginPath ()
            
            context?.move(to: CGPoint(x: 0, y: 0))
            
            context?.addLine(to: CGPoint(x: size.width, y: 0))
            
            context?.addLine(to: CGPoint(x: size.width, y: size.height))
            
            context?.addLine(to: CGPoint(x: 0, y: size.height))
            
            context?.addLine(to: CGPoint(x: size.width, y: 0))
            
            topImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            
            context?.closePath()
            
            context?.clip()
            
            bottomImage.draw(in: CGRect(x: 0,y: 0, width: size.width, height: size.height))
            
            mergedImage = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
        }
        
        return mergedImage
        
    }
    
    public func aspectFillImage(_ bounds:CGRect) -> UIImage? {
        
        let newSize = sizeWithContentMode(.scaleAspectFill, bounds:bounds)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        
        let x = (newSize.width - bounds.width) / 2
        
        let y = (newSize.height - bounds.height) / 2
        
        let rect = CGRect(x: -x, y: -y, width: newSize.width, height: newSize.height)
        
        draw(in: rect)
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return scaledImage
        
    }
    
    fileprivate func sizeWithContentMode(_ contentMode:UIViewContentMode, bounds:CGRect) -> CGSize {
        
        let hRatio = bounds.width / size.width
        
        let vRatio = bounds.height / size.height
        
        var ratio = CGFloat(0)
        
        switch (contentMode) {
            
        case .scaleAspectFill:
            
            ratio = max(hRatio, vRatio)
            
        case .scaleAspectFit:
            
            ratio = min(hRatio, vRatio)
            
        default:
            
            ratio = 1
            
        }
        
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        
        return newSize
        
    }
    
}
