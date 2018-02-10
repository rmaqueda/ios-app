import UIKit
import WebKit
class PostVC: UIViewController, WKUIDelegate, WKNavigationDelegate {
    let post: Post!
    var webView: WKWebView!
    let loadingIndicator : UIActivityIndicatorView = {
        var view = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        return view
    }()
    
    init(_ post : Post) {
        self.post = post
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
        view.addSubview(loadingIndicator)
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        let commentsButton = UIBarButtonItem(title: "Комментарии", style: .plain, target: self, action: #selector(commentsButtonAction))
        navigationItem.rightBarButtonItem = commentsButton
    }
    
    @objc func commentsButtonAction(){
        print("commentsButtonAction")
        show(CommentsVC(post), sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: post.url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        webView.navigationDelegate = self
    }
    
    func webView(_: WKWebView, didCommit: WKNavigation!) {
        print("didCommit", webView.url!)
        loadingIndicator.stopAnimating()
    }
    
    func webView(_: WKWebView, didStartProvisionalNavigation: WKNavigation!) {
        print("didStartProvisionalNavigation", webView.url!)
    }
    
    func webView(_: WKWebView, didReceiveServerRedirectForProvisionalNavigation: WKNavigation!){
        print("didReceiveServerRedirectForProvisionalNavigation", webView.url!)
    }
}
