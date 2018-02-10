import UIKit
import WebKit
class PostVC: UIViewController, WKUIDelegate, WKNavigationDelegate {
    let url: String!
    var webView: WKWebView!
    
    init(_ url : String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: url)
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
