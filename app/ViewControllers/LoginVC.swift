import UIKit
import WebKit
class LoginVC: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "http://pluma.me/signin")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        webView.navigationDelegate = self
    }
    
    func webView(_: WKWebView, didCommit: WKNavigation!) {
        print("didCommit", webView.url!)
    }
    
    func webView(_: WKWebView, didStartProvisionalNavigation: WKNavigation!) {
        print("didStartProvisionalNavigation", webView.url!)
    }
    
    func webView(_: WKWebView, didReceiveServerRedirectForProvisionalNavigation: WKNavigation!){
        print("didReceiveServerRedirectForProvisionalNavigation", webView.url!)
    }
}
