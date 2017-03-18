
import UIKit
import FoundationKit

open class NetworkImageView: ImageView {
    
    public var currentImageURL: URL?
    
    fileprivate var placeholder = ImageView()
    
    fileprivate func setupPlaceholder(_ size:CGSize) {
        
        if placeholder.superview == nil {
            
            placeholder.frame = bounds
            
            placeholder.isHidden = true
            
            placeholder.contentMode = .center
            
            placeholder.backgroundColor = UIColor.clear
            
            addViewAtIndexWithSizeAndCenter(placeholder, index:0, size:size)
            
        }
        
    }
    
    public func addPlaceholderImage(_ image:UIImage?) {
        
        let size = image != nil ? image!.size : CGSize.zero
        
        setupPlaceholder(size)
        
        placeholder.image = image
        
    }
    
    public func loadImage(_ image:UIImage?) {
        
        placeholder.isHidden = false
        
        runOnMainThread {
            
            self.placeholder.isHidden = image != nil
            
            self.image = image
            
        }
        
    }

    public func loadImageWithURLString(_ image:String?, completion:VoidCompletion?) {
        
        let imageURL = image != nil ? URL(string:image!) : nil

        loadImageWithURL(imageURL, completion:completion)
        
    }

    public func loadImageWithURL(_ imageURL:URL?, completion:VoidCompletion?) {
        
        loadImageWithURL(imageURL, defaultImage: nil, completion: completion)
        
    }
    
    public func loadImageWithURLString(_ image:String?, defaultImage:String?, completion:VoidCompletion?) {
        
        let imageURL = image != nil ? URL(string:image!) : nil
        
        loadImageWithURL(imageURL, defaultImage: defaultImage, completion: completion)
        
    }
    
    public func loadImageWithURL(_ imageURL:URL?, defaultImage:String?, completion:VoidCompletion?) {
        
        if currentImageURL == nil || (currentImageURL == imageURL) == false || image == nil {
            
            cancelLoading(currentImageURL)
            
            loadImage(imageURL, defaultImage: defaultImage, completion:completion)
            
        }
        
    }
    
    fileprivate func cancelLoading(_ currentImageURL:URL?) {
        
        image = nil
        
        if let url = currentImageURL {
            
            let cache = ImageCache.imageCache
            
            cache.cancelImageForURL(url)
            
        }
        
    }
    
    fileprivate func loadImage(_ imageURL:URL?, defaultImage:String?, completion:VoidCompletion?) {
        
        placeholder.isHidden = false
        
        currentImageURL = imageURL
        
        let cache = ImageCache.imageCache
        
        let defaultUIImage = defaultImage != nil ? UIImage(named: defaultImage!) : nil
        
        image = defaultUIImage
        
        if let imageURL = imageURL {
            
            cache.loadImageWithURL(imageURL) { [weak self] image, url in
                
                if let instance = self {
                    
                    if url == instance.currentImageURL {
                        
                        instance.image = image == nil ? defaultUIImage : image
                        
                        instance.placeholder.isHidden = instance.image != nil
                        
                    }
                    
                    completion?()
                    
                }
                
            }
            
        }
        
    }
    
}
