
import UIKit
import Foundation

open class WebViewController: ViewController, UIScrollViewDelegate, UIWebViewDelegate {

    open var url: URL!
    
    fileprivate var request: URLRequest!
    
    @IBOutlet open weak var webView: UIWebView!
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupWebView()
        
    }
    
    deinit{
        
        webView.delegate = nil
        
    }
    
    // MARK - Setup
    
    fileprivate func setupWebView() {
        
        webView.delegate = self
        
        webView.scrollView.delegate = self
        
        webView.scrollView.showsHorizontalScrollIndicator = false
        
        webView.scrollView.showsVerticalScrollIndicator = false
        
        request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        webView.loadRequest(request)
        
    }
    
    // MARK - Action
    
    @IBAction open func closeTapped(_ sender: AnyObject) {
        
        view.endEditing(true)
        
        hideViewController(self)
        
    }
    
    @IBAction open func backTapped(_ sender: AnyObject) {
        
        webView.goBack()
        
    }
    
    @IBAction open func forwardTapped(_ sender: AnyObject) {
        
        webView.goForward()
        
    }
    
    //MARK: - UIScrollViewDelegate
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let y = webView.scrollView.contentOffset.y
        
        if y < 0 {
            
            webView.scrollView.contentOffset = CGPoint.zero
            
        }
        
    }
    
    //MARK: - UIWebViewDelegate
    
    open func webViewDidStartLoad(_ webView: UIWebView) {
        
        LoadingUtils.showLoading(webView, activityIndicatorViewStyle: .gray)
        
    }
    
    open func webViewDidFinishLoad(_ webView: UIWebView) {
        
        LoadingUtils.hideLoading(view)
        
    }
    
    open func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        LoadingUtils.hideLoading(view)
        
    }
    
}
