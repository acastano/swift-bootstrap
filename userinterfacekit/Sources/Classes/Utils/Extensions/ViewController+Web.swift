
import UIKit
import Foundation
import SafariServices

public extension ViewController {
    
    public func presentWebViewController(_ url: URL) {
        
        if #available(iOS 9.0, *) {
            
            let controller = SFSafariViewController(url: url)
            
            present(controller, animated:true, completion: nil)
            
        } else {
            
            let controller: WebViewController = UIStoryboard.instantiateViewController()
            
            controller.url = url
            
            present(controller, animated:true, completion: nil)
            
        }
        
    }
    
}
